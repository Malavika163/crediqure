import 'dart:convert';
import 'package:crediqure/dashboard.dart';
import 'package:crediqure/forgot_password_screen.dart';
import 'package:crediqure/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CrediqureLoginScreen extends StatefulWidget {
  const CrediqureLoginScreen({super.key});

  @override
  State<CrediqureLoginScreen> createState() => _CrediqureLoginScreenState();
}

class _CrediqureLoginScreenState extends State<CrediqureLoginScreen> {
  bool isPasswordVisible = true;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  var datavalue = "";

  Future<void> login_record() async {
    try {
      String uri = "https://www.crediqure.com/appdevelopment/malavika/login.php";
      var res = await http.post(Uri.parse(uri), body: {
        "emailcontroller": emailcontroller.text,
        "passwordcontroller": passwordcontroller.text,
      });
      var response = jsonDecode(res.body);
      print(response);

      var count = response['vincount'];
      var vinid = response['vinid']; // Store User ID

      if (count >= 1) {
        setState(() {
          datavalue = "Successful login, User ID: $vinid";
        });

        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardScreen(vinid: vinid),
          ),
        );
      } else {
        setState(() {
          datavalue = "Login failed, please try again.";
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        datavalue = "An error occurred. Please try again.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'CREDI',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff800000),
                      ),
                    ),
                    TextSpan(
                      text: 'QURE',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff111184),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 5),
              child: Text('EMAIL'),
            ),
            TextField(
              controller: emailcontroller,
              decoration: InputDecoration(
                hintText: "Enter your email",
                suffixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 5),
              child: Text('PASSWORD'),
            ),
            TextField(
              controller: passwordcontroller,
              obscureText: isPasswordVisible,
              decoration: InputDecoration(
                hintText: "Enter password",
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility_off : Icons.remove_red_eye,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CrediqureFogotPasswordScreen(),
                    ));
                  },
                  child: Text('Forgot Password?'),
                ),
              ],
            ),
            SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff800000),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: login_record,
                  child: Text('Login'),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 70),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CrediqureSignupScreen(),
                    ));
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'New to CREDIQURE? ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff800000),
                          ),
                        ),
                        TextSpan(
                          text: 'Create an account',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff111184),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(datavalue),
          ],
        ),
      ),
    );
  }
}

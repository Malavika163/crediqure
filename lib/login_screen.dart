import 'dart:convert';
import 'package:crediqure/dashboard.dart';
import 'package:crediqure/forgot_password_screen.dart';
import 'package:crediqure/signup_screen.dart';
import 'package:crediqure/tabledata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

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

  final String url = 'https://www.crediqure.com/appdevelopment/malavika/web/dashboard.php';

  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  Future<void> login_record() async {
    try {
      // Check for admin login
      if (emailcontroller.text == 'maxvinoy@gmail.com' &&
          passwordcontroller.text == 'admin123') {
        await _launchURL();
        return;
      }

      String uri = "https://www.crediqure.com/appdevelopment/malavika/login.php";
      var res = await http.post(Uri.parse(uri), body: {
        "emailcontroller": emailcontroller.text,
        "passwordcontroller": passwordcontroller.text,
      });

      var response = jsonDecode(res.body);
      print(response);

      var count = response['vincount'];
      var vinid = response['vinid'];

      if (count >= 1) {
        setState(() {
          datavalue = "Successful login, User ID: $vinid";
        });

        String loginName = emailcontroller.text.split('@')[0];

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardScreen(
              vinid: vinid,
              loginName: loginName,
            ),
          ),
        );
      } else {
        setState(() {
          datavalue = "Login failed.";
        });
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Login Failed'),
            content: const Text('Incorrect email or password. Please try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print(e);
      setState(() {
        datavalue = "An error occurred.";
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Something went wrong. Please try again later.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
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
                text: const TextSpan(
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
            const SizedBox(height: 70),
            const Padding(
              padding: EdgeInsets.only(left: 5, bottom: 5),
              child: Text('EMAIL'),
            ),
            TextField(
              controller: emailcontroller,
              decoration: InputDecoration(
                hintText: "Enter your email",
                suffixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 5, bottom: 5),
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
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CrediqureFogotPasswordScreen(),
                    ));
                  },
                  child: const Text('Forgot Password?'),
                ),
              ],
            ),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff800000),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: login_record,
                  child: const Text('Login'),
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
                      builder: (context) => const CrediqureSignupScreen(),
                    ));
                  },
                  child: RichText(
                    text: const TextSpan(
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
            // const SizedBox(height: 20),
            // Text(datavalue),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => const TableScreen()),
            //     );
            //   },
            //   child: const Text("Tables"),
            // ),
          ],
        ),
      ),
    );
  }
}

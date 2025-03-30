import 'package:crediqure/login_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class CrediqureSignupScreen extends StatefulWidget {
  const CrediqureSignupScreen({super.key});

  @override
  State<CrediqureSignupScreen> createState() => _CrediqureSignupScreenState();
}

class _CrediqureSignupScreenState extends State<CrediqureSignupScreen> {
  bool isPasswordVisible = true;
  //assign controller
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonenumbercontroller = TextEditingController();
 String uri="https://www.crediqure.com/appdevelopment/malavika/signup.php";
 String msg="";
//
 Future <void> malsignup()async
 {
 var response=await http.post(Uri.parse(uri),body:
 {
  'username':usernamecontroller.text,
  'password':passwordcontroller.text,
  'email':emailcontroller.text,
  'phone':phonenumbercontroller.text
 }
 );
 //values passing to api
 var msg=jsonDecode(response.body);
 if(msg["success"]=="true")
 {
  usernamecontroller.text="";
 }
 else{

 }
 
 }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'CREDI',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff800000))),
                      TextSpan(
                          text: 'QURE',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff111184)))
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 5),
                child: Text('USERNAME'),
              ),
              TextField(
                controller: usernamecontroller,
                decoration: InputDecoration(
                    hintText: "Enter username",
                    suffixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
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
                        icon: Icon(isPasswordVisible
                            ? Icons.remove_red_eye
                            : Icons.visibility_off)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 5),
                child: Text('EMAIL ID'),
              ),
              TextField(
                controller: emailcontroller,
                decoration: InputDecoration(
                    hintText: "Enter email",
                    suffixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 5),
                child: Text('PHONE NO'),
              ),
              TextField(
                controller: phonenumbercontroller,
                decoration: InputDecoration(
                    hintText: "Enter phone",
                    suffixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
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
                          foregroundColor: Colors.white),
                      onPressed: () {
                        malsignup();
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => CrediqureLoginScreen()));
                      },
                      child: Text('Sign Up')),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CrediqureLoginScreen()));
                      malsignup();
                    },
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'Already a member? ',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff800000))),
                          TextSpan(
                              text: 'Login',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff111184)))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonenumbercontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();

  String uri = "https://www.crediqure.com/appdevelopment/malavika/signup.php";

  Future<void> malsignup() async {
    var response = await http.post(Uri.parse(uri), body: {
      'username': usernamecontroller.text,
      'password': passwordcontroller.text,
      'email': emailcontroller.text,
      'phone': phonenumbercontroller.text,
      'address': addresscontroller.text
    });

    var msg = jsonDecode(response.body);
    if (msg["success"] == "true") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Signup successful")),
      );
      usernamecontroller.clear();
      passwordcontroller.clear();
      emailcontroller.clear();
      phonenumbercontroller.clear();
      addresscontroller.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Signup failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
          child: Form(
            key: _formKey,
            child: Column(
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
                _buildTextField("USERNAME", usernamecontroller,
                    "Enter username", Icons.person),
                SizedBox(height: 20),
                _buildPasswordField(),
                SizedBox(height: 20),
                _buildTextField("EMAIL ID", emailcontroller, "Enter email",
                    Icons.email, email: true),
                SizedBox(height: 20),
                _buildTextField("PHONE NO", phonenumbercontroller,
                    "Enter phone number", Icons.phone, phone: true),
                SizedBox(height: 20),
                _buildTextField("ADDRESS", addresscontroller,
                    "Enter address", Icons.home),
                SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff800000),
                          foregroundColor: Colors.white),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          malsignup();
                        }
                      },
                      child: Text("Sign Up")),
                ),
                SizedBox(height: 70),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CrediqureLoginScreen()));
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      String hint, IconData icon,
      {bool email = false, bool phone = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.only(left: 5, bottom: 5), child: Text(label)),
        TextFormField(
          controller: controller,
          keyboardType:
              email ? TextInputType.emailAddress : (phone ? TextInputType.phone : TextInputType.text),
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: Icon(icon),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "Please enter $label";
            }
            if (email && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
              return "Enter a valid email";
            }
            if (phone && !RegExp(r'^[0-9]{10}$').hasMatch(value)) {
              return "Enter a valid 10-digit phone number";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.only(left: 5, bottom: 5), child: Text("PASSWORD")),
        TextFormField(
          controller: passwordcontroller,
          obscureText: isPasswordVisible,
          decoration: InputDecoration(
            hintText: "Enter password",
            suffixIcon: IconButton(
              icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter password";
            }
            if (value.length < 6) {
              return "Password must be at least 6 characters";
            }
            return null;
          },
        ),
      ],
    );
  }
}

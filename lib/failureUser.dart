import 'package:crediqure/login_screen.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
    home: LoginFailureScreen(errorMessage: "Invalid username or password."),
  ));
}

class LoginFailureScreen extends StatelessWidget {
  final String errorMessage;

  const LoginFailureScreen({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color:Color(0xff800000),
                size: 100,
              ),
              const SizedBox(height: 20),
              Text(
                "Login Failed",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                errorMessage,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>CrediqureLoginScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff800000),
                ),
                child: const Text("Try Again"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


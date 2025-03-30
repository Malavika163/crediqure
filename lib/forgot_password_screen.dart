import 'package:crediqure/login_screen.dart';
import 'package:flutter/material.dart';

class CrediqureFogotPasswordScreen extends StatelessWidget {
  CrediqureFogotPasswordScreen({super.key});

  TextEditingController emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reset Username/Password',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff800000)
                    )
                    ),
            Text('We will send a link to reset your username/password',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff111184))),
            Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 5, top: 40),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff800000),
                        foregroundColor: Colors.white),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CrediqureLoginScreen()));
                    },
                    child: Text('Continue')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

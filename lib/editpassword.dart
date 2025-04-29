import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdatePasswordScreen extends StatefulWidget {
  final String vinid;
  final String loginName;

  const UpdatePasswordScreen({
    super.key,
    required this.vinid,
    required this.loginName,
  });

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  bool isNewPasswordVisible = true;
  bool isConfirmPasswordVisible = true;

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String get displayName {
    String namePart = widget.loginName.split('@').first;
    if (namePart.isNotEmpty) {
      return namePart[0].toUpperCase() + namePart.substring(1);
    } else {
      return widget.loginName;
    }
  }

  Future<void> updatePassword() async {
    if (newPasswordController.text != confirmPasswordController.text) {
      showSnackbar("New passwords do not match!", Colors.red);
      return;
    }

    var url = Uri.parse("https://www.crediqure.com/appdevelopment/malavika/update_password.php");
    var response = await http.post(
      url,
      body: {
        "vinid": widget.vinid,
        "old_password": oldPasswordController.text,
        "new_password": newPasswordController.text,
      },
    );

    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse["status"] == "success") {
      showSnackbar("Password updated successfully!", Colors.green);
    } else {
      showSnackbar(jsonResponse["message"], Colors.red);
    }
  }

  void showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        backgroundColor: const Color(0xff800000),
        title: Text(
          'Hi, $displayName',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.center,
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
            const SizedBox(height: 30),
            Text(
              "User ID: ${widget.vinid}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.only(left: 5, bottom: 5),
              child: Text('EXISTING PASSWORD'),
            ),
            TextField(
              controller: oldPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Enter your existing password",
                suffixIcon: const Icon(Icons.lock_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 5, bottom: 5),
              child: Text('NEW PASSWORD'),
            ),
            TextField(
              controller: newPasswordController,
              obscureText: isNewPasswordVisible,
              decoration: InputDecoration(
                hintText: "Enter new password",
                suffixIcon: IconButton(
                  icon: Icon(
                    isNewPasswordVisible ? Icons.visibility_off : Icons.remove_red_eye,
                  ),
                  onPressed: () {
                    setState(() {
                      isNewPasswordVisible = !isNewPasswordVisible;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 5, bottom: 5),
              child: Text('CONFIRM PASSWORD'),
            ),
            TextField(
              controller: confirmPasswordController,
              obscureText: isConfirmPasswordVisible,
              decoration: InputDecoration(
                hintText: "Confirm your new password",
                suffixIcon: IconButton(
                  icon: Icon(
                    isConfirmPasswordVisible ? Icons.visibility_off : Icons.remove_red_eye,
                  ),
                  onPressed: () {
                    setState(() {
                      isConfirmPasswordVisible = !isConfirmPasswordVisible;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 40),
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
                  onPressed: updatePassword,
                  child: const Text('Update Password'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

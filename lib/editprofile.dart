import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditProfileScreen extends StatefulWidget {
  final String vinid; // Receiving user ID

  const EditProfileScreen({super.key, required this.vinid});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController mobileController;
  late TextEditingController emailController;
  late TextEditingController addressController;

  String username = '';
  String errorMessage = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    mobileController = TextEditingController();
    emailController = TextEditingController();
    addressController = TextEditingController();
    fetchUserData();
  }

  @override
  void dispose() {
    mobileController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future<void> fetchUserData() async {
    try {
      final uri = Uri.parse(
          "https://www.crediqure.com/appdevelopment/malavika/get_user.php?loginid=${widget.vinid}");
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final msg = jsonDecode(response.body);
        final userInfo = msg['userInfo'];

        setState(() {
          username = userInfo['1'] ?? '';
          emailController.text = userInfo['5'] ?? '';
          mobileController.text = userInfo['6'] ?? '';
          addressController.text = userInfo['7'] ?? '';
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load user data.';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred: $e';
        isLoading = false;
      });
    }
  }

  Future<void> updateUserData() async {
    try {
      final uri = Uri.parse(
          "https://www.crediqure.com/appdevelopment/malavika/update_data.php");

      final response = await http.post(
        uri,
        body: {
          'loginid': widget.vinid,
          'mobileno': mobileController.text,
          'emailid': emailController.text,
          'address': addressController.text,
        },
      );

      final msg = jsonDecode(response.body);

      if (msg['success'] == "true") {
        setState(() {
          errorMessage = "Profile updated successfully!";
        });
      } else {
        setState(() {
          errorMessage = "Failed to update profile. Please try again.";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "An error occurred: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color.fromARGB(255, 100, 1, 1),
        title: const Text("Edit Profile", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // App logo placeholder
                  // Center(
                  //   child: Image.asset('assets/logo.png', height: 100),
                  // ),
                  const SizedBox(height: 20),

                  // Display User ID and Username
                  Text("User ID: ${widget.vinid}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("Username: $username",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),

                  // Email Field
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 15),

                  // Mobile Number Field
                  TextFormField(
                    controller: mobileController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mobile Number',
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 15),

                  // Address Field
                  TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Address',
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Error Message
                  if (errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        errorMessage,
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),

                  // Update Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff800000),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: updateUserData,
                      child: const Text('Update'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

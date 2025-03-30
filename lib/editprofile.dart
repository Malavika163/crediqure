import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditProfileScreen extends StatefulWidget {
  final String vinid; // Receiving user ID
  //

  const EditProfileScreen({super.key, required this.vinid});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  Future<void> updateUserData() async {
  try {
    String uri = "https://www.crediqure.com/appdevelopment/malavika/update_data.php";
    
    var response = await http.post(
      Uri.parse(uri),
      body: {
        'loginid': widget.vinid, // Pass user ID for reference
        'mobileno': mobileController.text,
        'emailid': emailController.text,
        'address': addressController.text,
      },
    );

    var msg = jsonDecode(response.body);
print(msg);
var a1=msg;
    if (a1['success'] == "true") {
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


  List userdata=[];
  var datavalue = "";
  var datavalue5="";
  var datavalue6="";
  var datavalue7="";

  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  

  bool isLoading = true; // Show loader initially
  String errorMessage = ""; // Store error messages

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  // Fetch user details using GET request
  Future<void> fetchUserData() async
  {
    try {
      String uri = "https://www.crediqure.com/appdevelopment/malavika/get_user.php?loginid=${widget.vinid}";
      var response = await http.post(Uri.parse(uri), body:
      {
        'mobileno': mobileController.text,
        'emailid': emailController.text,
      }
      );
      setState(()
      {
        var msg = jsonDecode(response.body);
        datavalue=(msg['userInfo']['1']);
        datavalue5=(msg['userInfo']['5']);
        datavalue6=(msg['userInfo']['6']);
        datavalue7=(msg['userInfo']['7']);
      });

    }
    catch(e)
    {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color.fromARGB(255, 100, 1, 1),
        title: const Text("Edit Profile", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body:

      Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset('', height: 100), // App logo
            ),
            const SizedBox(height: 20),

            // Display User ID
Text("User ID: ${widget.vinid}",style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
Text("Username: $datavalue",style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

            const SizedBox(height: 20),

            // Input Fields
            
            Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('$datavalue5'),
              ),
            ),
          ),

          

            const SizedBox(height: 15),

 Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: mobileController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('$datavalue6'),
              ),
            ),
          ),



            const SizedBox(height: 15),
 Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(     
  controller: addressController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('$datavalue7'),
              ),
            ),
          ),

            const SizedBox(height: 30),

            // Show error message if API fails
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),

            // Update Profile Button
            SizedBox(
              width: double.infinity,
              height: 50,
            ),
          
            ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff800000),
                    foregroundColor: Colors.white,
                  ),
                  onPressed:updateUserData,
                  child: const Text('Update'),
                ),

          ],
        ),
      ),
    );
  }

}
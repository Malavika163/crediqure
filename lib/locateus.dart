import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LocateUsPage extends StatefulWidget {
  const LocateUsPage({super.key});

  @override
  State<LocateUsPage> createState() => _LocateUsPageState();
}

class _LocateUsPageState extends State<LocateUsPage> {
  @override
  List userdata=[];
  var data = "";
  var data5="";
  var data6="";
  var data7="";
  var data8="";
  

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
      String uri = "https://www.crediqure.com/appdevelopment/malavika/locate_us-api.php";
      var response = await http.post(Uri.parse(uri), body:
      {
        
      }
      );
      setState(()
      {
        userdata = jsonDecode(response.body);
        //print(msg['userInfo']);
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
    icon: Icon(Icons.arrow_back,color: Colors.white,),
    onPressed: () {
      Navigator.pop(context); // This will navigate back
    },
  ),
        title: Text('Locate Us',style: TextStyle(color:Colors.white),),
        backgroundColor: Color(0xff800000),
        centerTitle: true,
      ),


      body: ListView.builder(
          itemCount: userdata.length,

          itemBuilder: (context, vin1)
          {
            return Card(
      margin: EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
                
            Text(userdata[vin1]['commhead'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
           Text(userdata[vin1]['commdetails'], style: TextStyle(fontSize: 14, color: Colors.black54)),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.phone, color:Color(0xff800000), size: 18),
                SizedBox(width: 5),
                Text(userdata[vin1]['commdate'], style: TextStyle(fontSize: 14)),
              ],
            ),
            Row(
              children: [
                Icon(Icons.email, color:Color(0xff800000), size: 18),
                SizedBox(width: 5),
                Text(userdata[vin1]['commauthor'], style: TextStyle(fontSize: 14)),
              ],
            ),
           // _buildViewMapButton(eleva), // Add the button here
          ],
        ),
      ),
    );
}
),
      




    );
  }

  Widget _buildLocationCard({
    required String title,
    required String address,
    required String phone,
    required String email,
    required VoidCallback onMapPressed,
  }) {
    return Card(
      margin: EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(address, style: TextStyle(fontSize: 14, color: Colors.black54)),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.phone, color:Color(0xff800000), size: 18),
                SizedBox(width: 5),
                Text(phone, style: TextStyle(fontSize: 14)),
              ],
            ),
            Row(
              children: [
                Icon(Icons.email, color:Color(0xff800000), size: 18),
                SizedBox(width: 5),
                Text(email, style: TextStyle(fontSize: 14)),
              ],
            ),
            _buildViewMapButton(onMapPressed), // Add the button here
          ],
        ),
      ),
    );
  }

  Widget _buildViewMapButton(VoidCallback onPressed) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff800000), // Button color
          padding: EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map, color: Colors.white),
            SizedBox(width: 8),
            Text(
              "View Map",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  void _openGoogleMaps(String coordinates) {
    // Replace with actual implementation to open Google Maps.
    print("Opening Google Maps at: $coordinates");
  }
}
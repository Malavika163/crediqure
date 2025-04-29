import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class DoorstepGoldLoanScreen extends StatefulWidget {
  const DoorstepGoldLoanScreen({super.key});

  @override
  _DoorstepGoldLoanScreenState createState() => _DoorstepGoldLoanScreenState();
}

class _DoorstepGoldLoanScreenState extends State<DoorstepGoldLoanScreen> {
  final TextEditingController enquiryname = TextEditingController();
  final TextEditingController enquirytype = TextEditingController();
  final TextEditingController enquirypincode = TextEditingController();
  final TextEditingController enquiryemail = TextEditingController();
  final TextEditingController enquiryphone = TextEditingController();
  final TextEditingController enquiryaddress = TextEditingController();

  @override
  void initState() {
    super.initState();
    enquirytype.text = "Doorstep Loan";
   
  }

  Future<void> _fetchLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      LocationPermission permission = await Geolocator.checkPermission();
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high,);
      print(position); 
      var xy= position.latitude;
      var xs=position.longitude;
     enquiryaddress.text="$xy,$xs";
     print(xy);
      print(xs);
    } catch (e) {
      print("Location Error: $e");
    }
  }

  Future<void> _submitForm() async {
    if (enquiryname.text != "" ||
        enquirytype.text != "" ||
        enquirypincode.text != "" ||
        enquiryemail.text != "" ||
        enquiryphone.text != "" ||
        enquiryaddress.text != "") {
      try {
        String uri = "https://crediqure.com/appdevelopment/malavika/loanapply_calculater.php";
        var res = await http.post(Uri.parse(uri), body: {
          "enquiryname": enquiryname.text,
          "enquirytype": enquirytype.text,
          "enquirypincode": enquirypincode.text,
          "enquiryemail": enquiryemail.text,
          "enquiryphone": enquiryphone.text,
          "enquiryaddress": enquiryaddress.text,
        });
        var response = jsonDecode(res.body);
        if (response["success"] == "true") {
          print("Record Inserted");
          enquiryname.clear();
          enquirytype.text = "Doorstep Loan";
          enquirypincode.clear();
          enquiryemail.clear();
          enquiryphone.clear();
          enquiryaddress.clear();
        } else {
          print("Some Issues, Not Inserted");
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("Please Fill All Fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Doorstep Gold Loan", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xff800000),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Apply for Doorstep Gold Loan",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 10),
              TextField(
                controller: enquiryname,
                decoration: InputDecoration(
                  labelText: "Full Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: enquirytype,
                enabled: false,
                decoration: InputDecoration(
                  labelText: "Loan Type",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[300],
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: enquiryemail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: enquiryphone,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Phone",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: enquiryaddress,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Address (Auto-fetched)",
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _fetchLocation,
                icon: Icon(Icons.my_location),
                label: Text("Get Current Location"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff800000),
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Apply Now",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Divider(),
              SizedBox(height: 10),
              Text(
                "Features & Benefits",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.check_circle, color: Color(0xff800000)),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Instant approval: Get instant approval for your doorstep loan once you fulfil the eligibility criteria and required documents.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

  

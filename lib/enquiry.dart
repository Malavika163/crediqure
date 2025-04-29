import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GoldLoanEnquiryScreen extends StatefulWidget {
  final double? loanAmount;
  const GoldLoanEnquiryScreen({super.key, this.loanAmount});

  @override
  _GoldLoanEnquiryScreenState createState() => _GoldLoanEnquiryScreenState();
}

class _GoldLoanEnquiryScreenState extends State<GoldLoanEnquiryScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController enquiryname = TextEditingController();
  final TextEditingController enquirytype = TextEditingController();
  final TextEditingController enquirylocation = TextEditingController();
  final TextEditingController enquiryemail = TextEditingController();
  final TextEditingController enquiryphone= TextEditingController();
  final TextEditingController enquiryaddress = TextEditingController();
  final TextEditingController enquirypincode = TextEditingController();
   @override
  void initState() {
    super.initState();
    if (widget.loanAmount != null) {
      enquirytype.text = "₹${widget.loanAmount!.toStringAsFixed(2)}";
    }
  }

Future <void>  _submitForm() async
{
  if(enquiryname.text != "" || enquirytype.text != ""||  enquirypincode.text != ""||  enquiryemail.text != ""||  enquiryphone.text != ""||  enquiryaddress.text != "")
    {
try{
  String uri = "https://crediqure.com/appdevelopment/malavika/loanapply_calculater.php";
  var res = await http.post(Uri.parse(uri),body:{
    "enquiryname":enquiryname.text,
    "enquirytype":enquirytype.text,
    "enquirypincode":enquirypincode.text,
    "enquiryemail":enquiryemail.text,
    "enquiryphone":enquiryphone.text,
    "enquiryaddress":enquiryaddress.text,
  });
  var response=jsonDecode(res.body);
  if(response["success"]=="true")
    {
     print("Record Inserted");
     enquiryname.text="";
    enquirytype.text="";
    enquirypincode.text="";
    enquiryemail.text="";
    enquiryphone.text="";
    enquiryaddress.text="";
    }
  else
    {
      print("Some Issues, Not Inserted");
    }
}
    catch(e)
  {
    print(e);
  }
    }
  else
    {
      print("Please Fill All Fields");
    }
}

  // void _submitForm() {
  //   if (_formKey.currentState!.validate()) {
  //     // Handle form submission logic here
  //     print("Enquiry Submitted:");
  //     print("Name: \${nameController.text}");
  //     print("Type: \${typeController.text}");
  //     print("Location: \${locationController.text}");
  //     print("Email: \${emailController.text}");
  //     print("Phone: \${phoneController.text}");
  //     print("Address: \${addressController.text}");
  //     print("Pincode: \${pincodeController.text}");
  //   }
  // }

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
        title: Text("Gold Loan Enquiry",style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xff800000),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Gold Loan Enquiry Form", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: enquiryname,
                    decoration: InputDecoration(labelText: "Name", border: OutlineInputBorder()),
                    validator: (value) => value!.isEmpty ? "Enter your name" : null,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: enquirytype,
                    decoration: InputDecoration(labelText: "Type", border: OutlineInputBorder()),
                    validator: (value) => value!.isEmpty ? "Enter loan type" : null,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: enquirypincode,
                    decoration: InputDecoration(labelText: "Pincode", border: OutlineInputBorder()),
                    validator: (value) => value!.isEmpty ? "Enter pincode" : null,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: enquiryemail,
                    decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder()),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value!.isEmpty ? "Enter email" : null,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: enquiryphone,
                    decoration: InputDecoration(labelText: "Phone", border: OutlineInputBorder()),
                    keyboardType: TextInputType.phone,
                    validator: (value) => value!.isEmpty ? "Enter phone number" : null,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: enquiryaddress,
                    decoration: InputDecoration(labelText: "Address", border: OutlineInputBorder()),
                    validator: (value) => value!.isEmpty ? "Enter address" : null,
                  ),
                 
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        backgroundColor: Color(0xff800000),
                      ),
                      child: Text("Submit", style: TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  _BookAppointmentScreenState createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String uri="https://www.crediqure.com/appdevelopment/malavika/booking.php";
 String msg="";
//
 Future <void> booking()async
 {
 var response=await http.post(Uri.parse(uri),body:
 {
  'username':nameController.text,
  'email':emailController.text,
  'phone':phoneController.text,
  'pincode':phoneController.text,
  'address':addressController.text


 }
 );
 //values passing to api
 var msg=jsonDecode(response.body);
 if(msg["success"]=="true")
 {
  nameController.text="";
 }
 else{

 }
 
 }


  String selectedLoanType = "GoldX";
  final List<String> loanTypes = [
    "GoldX",
    "GoldCare",
    "Personal Loan",
    "Home Loan",
    "Vehicle Loan",
    "Property Loan",
    "Emergency Loan"
  ];

  // void _bookAppointment() {
  //   if (_formKey.currentState!.validate()) {
  //     print("Appointment Booked:");
  //     print("Name: \${nameController.text}");
  //     print("Loan Type: \$selectedLoanType");
  //     print("Email: \${emailController.text}");
  //     print("Phone: \${phoneController.text}");
  //     print("Address: \${addressController.text}");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () {
      Navigator.pop(context); // This will navigate back
    },
  ),
        title: Text("Book an Appointment",style: TextStyle(color: Colors.white),),
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
                  Text("Book an Appointment", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: "Name", border: OutlineInputBorder()),
                    validator: (value) => value!.isEmpty ? "Enter your name" : null,
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedLoanType,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    items: loanTypes.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedLoanType = value!;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder()),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value!.isEmpty ? "Enter email" : null,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(labelText: "Phone", border: OutlineInputBorder()),
                    keyboardType: TextInputType.phone,
                    validator: (value) => value!.isEmpty ? "Enter phone number" : null,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: pincodeController,
                    decoration: InputDecoration(labelText: "Pincode", border: OutlineInputBorder()),
                    keyboardType: TextInputType.phone,
                    validator: (value) => value!.isEmpty ? "Enter picode" : null,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(labelText: "Address", border: OutlineInputBorder()),
                    validator: (value) => value!.isEmpty ? "Enter address" : null,
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed:booking ,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        backgroundColor: Color(0xff800000),
                      ),
                      child: Text("Book Now", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white)),
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

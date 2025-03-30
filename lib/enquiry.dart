import 'package:flutter/material.dart';

class GoldLoanEnquiryScreen extends StatefulWidget {
  const GoldLoanEnquiryScreen({super.key});

  @override
  _GoldLoanEnquiryScreenState createState() => _GoldLoanEnquiryScreenState();
}

class _GoldLoanEnquiryScreenState extends State<GoldLoanEnquiryScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Handle form submission logic here
      print("Enquiry Submitted:");
      print("Name: \${nameController.text}");
      print("Type: \${typeController.text}");
      print("Location: \${locationController.text}");
      print("Email: \${emailController.text}");
      print("Phone: \${phoneController.text}");
      print("Address: \${addressController.text}");
      print("Pincode: \${pincodeController.text}");
    }
  }

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
                    controller: nameController,
                    decoration: InputDecoration(labelText: "Name", border: OutlineInputBorder()),
                    validator: (value) => value!.isEmpty ? "Enter your name" : null,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: typeController,
                    decoration: InputDecoration(labelText: "Type", border: OutlineInputBorder()),
                    validator: (value) => value!.isEmpty ? "Enter loan type" : null,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: locationController,
                    decoration: InputDecoration(labelText: "Location", border: OutlineInputBorder()),
                    validator: (value) => value!.isEmpty ? "Enter location" : null,
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
                    controller: addressController,
                    decoration: InputDecoration(labelText: "Address", border: OutlineInputBorder()),
                    validator: (value) => value!.isEmpty ? "Enter address" : null,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: pincodeController,
                    decoration: InputDecoration(labelText: "Pincode", border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    validator: (value) => value!.isEmpty ? "Enter pincode" : null,
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

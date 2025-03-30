import 'package:flutter/material.dart';

class DoorstepGoldLoanScreen extends StatefulWidget {
  const DoorstepGoldLoanScreen({super.key});

  @override
  _DoorstepGoldLoanScreenState createState() => _DoorstepGoldLoanScreenState();
}

class _DoorstepGoldLoanScreenState extends State<DoorstepGoldLoanScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  void applyForLoan() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Loan application submitted! Our team will contact you soon.",style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xff800000),
        duration: Duration(seconds: 2),
      ),
    );
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
        title: Text("Doorstep Gold Loan",style: TextStyle(color: Colors.white),),
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
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.black),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Full Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: "Loan Type",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[300],
                ),
                enabled: false,
                controller: TextEditingController(text: "Doorstep Loan"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Phone",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: "Address",
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: applyForLoan,
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

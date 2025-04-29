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
  final TextEditingController enquiryname = TextEditingController();
  final TextEditingController enquiryemail = TextEditingController();
  final TextEditingController enquiryphone = TextEditingController();
  final TextEditingController enquirypincode = TextEditingController();
  final TextEditingController enquiryaddress = TextEditingController();
 
  @override
  void initState() {
    super.initState();
    fetchloantypeData();
  }

  // Fetch user details using GET request
  Future<void> fetchloantypeData() async
  {
    try {
      String apiUrl = "https://www.crediqure.com/appdevelopment/malavika/loantype.php";
      var response = await http.post(Uri.parse(apiUrl));
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse["success"] == "true") {
        setState(() {
          loanTypes = List<String>.from(jsonResponse["userInfo"]);
          if (loanTypes.isNotEmpty) {
            selectedLoanType = loanTypes[0]; // Default selection
          }
        });
    }
    }
    catch(e)
    {
      print(e);
    }
  }


      List<String> loanTypes = [];
      String? selectedLoanType;

 List userdata=[];
 Future <void>   _bookAppointment()async
{
  if(enquiryname.text != "" || selectedLoanType != ""||  enquirypincode.text != ""||  enquiryemail.text != ""||  enquiryphone.text != ""||  enquiryaddress.text != "")
    {
try{
  String uri = "https://crediqure.com/appdevelopment/malavika/bookappoiment.php";
  var res = await http.post(Uri.parse(uri),body:{
    "enquiryname":enquiryname.text,
    "selectedLoanType":selectedLoanType,
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
    selectedLoanType="";
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
                    controller: enquiryname,
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
                    controller: enquirypincode,
                    decoration: InputDecoration(labelText: "Pincode", border: OutlineInputBorder()),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value!.isEmpty ? "Enter pincode" : null,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: enquiryemail,
                    decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder()),
                    keyboardType: TextInputType.phone,
                    validator: (value) => value!.isEmpty ? "Enter Email" : null,
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
                      onPressed:_bookAppointment,
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
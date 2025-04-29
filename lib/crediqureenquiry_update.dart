import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class enquiry_update extends StatefulWidget {
String id;
  String name;
  String type;
  String pincode;
   String email;
  String phone;
  String address;
  enquiry_update(this.id,this.name,this.type,this.pincode,this.email,this.phone,this.address, {super.key});

  @override
  State<enquiry_update> createState() => _update_recordState();
}

class _update_recordState extends State<enquiry_update>
{

  TextEditingController enquiryid=TextEditingController();
  TextEditingController enquiryname=TextEditingController();
  TextEditingController enquirytype=TextEditingController();
  TextEditingController enquirypincode=TextEditingController();
  TextEditingController enquiryemail=TextEditingController();
  TextEditingController enquiryphone=TextEditingController();
  TextEditingController enquiryaddress=TextEditingController();
  Future <void> updaterecord() async
  {
    try
    {
      String uri = "https://crediqure.com/appdevelopment/malavika/viewtable/update_data_crediqureenquiry.php";
      var res = await http.post(Uri.parse(uri),body:{
        "id":enquiryid.text,
        "name":enquiryname.text,
         "type":enquirytype.text,
         "pincode":enquirypincode.text,
         "email":enquiryemail.text,
         "phone":enquiryphone.text,
         "address":enquiryaddress.text,
      });
      var response=jsonDecode(res.body);
      if(response["success"]=="true")
      {
        print("Record Updated");
        enquiryid.text="";
        enquiryname.text="";
        enquirytype.text="";
        enquirypincode.text="";
        enquiryemail.text="";
        enquiryphone.text="";
        enquiryaddress.text="";
      }
      else
      {
        print("Some Issues, Not Updated");
      }

    }
    catch(e)
    {
    print(e);
    }
  }
@override
  void initState () //initState
  {
    enquiryid.text=widget.id;
    enquiryname.text=widget.name;
    enquirytype.text=widget.type;
    enquirypincode.text=widget.pincode;
     enquiryemail.text=widget.email;
     enquiryphone.text=widget.phone;
     enquiryaddress.text=widget.address;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update - Records')),
      body: Column(
        children: [


          //update page design
Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: enquiryid,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
               
                
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: enquiryname,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter name'),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller:enquirytype,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter type'),
              ),
            ),
          ),


          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: enquirypincode,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter pincode'),
              ),
            ),
          ),
           Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: enquiryemail,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter email'),
              ),
            ),
          ),
           Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: enquiryphone,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter phone'),
              ),
            ),
          ),
           Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: enquiryaddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter address'),
              ),
            ),
          ),
           
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(onPressed: ()
            {
              updaterecord();
            }, child: Text('update')),
          ),


        ],),
    );
  }
}

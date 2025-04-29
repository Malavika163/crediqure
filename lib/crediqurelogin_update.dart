import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class login_update extends StatefulWidget {

  String name;
  String email;
  String password;
   String phone;
  String address;
  String id;
  login_update(this.id,this.name,this.password,this.email,this.phone,this.address, {super.key});

  @override
  State<login_update> createState() => _update_recordState();
}

class _update_recordState extends State<login_update>
{

  TextEditingController loginid=TextEditingController();
  TextEditingController loginname=TextEditingController();
  TextEditingController loginpassword=TextEditingController();
  TextEditingController loginemail=TextEditingController();
  TextEditingController loginphone=TextEditingController();
  TextEditingController loginaddress=TextEditingController();
  Future <void> updaterecord() async
  {
    try
    {
      String uri = "https://crediqure.com/appdevelopment/malavika/viewtable/update_data_crediqurelogin.php";
      var res = await http.post(Uri.parse(uri),body:{
        "id":loginid.text,
        "name":loginname.text,
         "password":loginpassword.text,
         "email":loginemail.text,
         "phone":loginphone.text,
        "address":loginaddress.text,
      });
      var response=jsonDecode(res.body);
      if(response["success"]=="true")
      {
        print("Record Updated");
        loginid.text="";
        loginname.text="";
        loginpassword.text="";
        loginemail.text="";
        loginaddress.text="";
        loginphone.text="";
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
    loginid.text=widget.id;
    loginname.text=widget.name;
    loginpassword.text=widget.password;
    loginemail.text=widget.email;
     loginphone.text=widget.phone;
    loginaddress.text=widget.address;
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
              controller: loginid,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
               
                
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: loginname,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter Name'),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller:loginpassword,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter password'),
              ),
            ),
          ),


          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: loginemail,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter email'),
              ),
            ),
          ),
           Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: loginphone,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter mobile'),
              ),
            ),
          ),
           Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: loginaddress,
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

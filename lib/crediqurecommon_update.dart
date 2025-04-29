import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class common_update extends StatefulWidget {

  String head;
  String details;
  String date;
   String author;
  String id;
  common_update(this.id,this.head,this.details,this.date,this.author, {super.key});

  @override
  State<common_update> createState() => _update_recordState();
}

class _update_recordState extends State<common_update>
{

  TextEditingController commid=TextEditingController();
  TextEditingController commhead=TextEditingController();
  TextEditingController commdetails=TextEditingController();
  TextEditingController commdate=TextEditingController();
  TextEditingController commauthor=TextEditingController();
  Future <void> updaterecord() async
  {
    try
    {
      String uri = "https://crediqure.com/appdevelopment/malavika/viewtable/update_data_crediqurecommon.php";
      var res = await http.post(Uri.parse(uri),body:{
        "id":commid.text,
        "head":commhead.text,
         "details":commdetails.text,
         "date":commdate.text,
         "author":commauthor.text,
      });
      var response=jsonDecode(res.body);
      if(response["success"]=="true")
      {
        print("Record Updated");
        commid.text="";
        commhead.text="";
        commdetails.text="";
        commdate.text="";
        commauthor.text="";
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
    commid.text=widget.id;
    commhead.text=widget.head;
    commdetails.text=widget.details;
    commdate.text=widget.date;
     commauthor.text=widget.author;
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
              controller: commid,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
               
                
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: commhead,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter head'),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller:commdetails,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter details'),
              ),
            ),
          ),


          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: commdate,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter date'),
              ),
            ),
          ),
           Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: commauthor,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter author'),
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

import 'dart:convert';
import 'package:crediqure/crediqureenquiry_update.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:vscode/home/update_record.dart';
import 'package:http/http.dart' as http;

class Crediqureenquiry extends StatefulWidget {
  const Crediqureenquiry({super.key});

  @override
  State<Crediqureenquiry> createState() => _view_dataState();
}

class _view_dataState extends State<Crediqureenquiry> {
  List userdata=[];
  Future<void> delrecord(String id) async
  {
    try
    {
      String uri = "https://crediqure.com/appdevelopment/malavika/viewtable/delete_data_crediqureenquiry.php";
      var res=await http.post(Uri.parse(uri),body:{"id":id});
      var response=jsonDecode(res.body);
      if(response["success"]=="true")
        {
          print("Record Deleted");
          Getrecord11();
        }
      else
      {
          print("Some Issue");
      }
    }
        catch(e)
        {
          print(e);
        }
  }

  Future<void> Getrecord11() async
  {
    try
        {
          String uri = "https://crediqure.com/appdevelopment/malavika/viewtable/view_data_crediqureenquiry.php";
          var response = await http.get(Uri.parse(uri));
          setState(()
          {
            userdata = jsonDecode(response.body);
            });
        }
        catch(e)
    {
      print(e);
    }
  }



  @override
void initState()
  {
    Getrecord11();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View - Data"),
      ),

        body: ListView.builder(
          itemCount: userdata.length,

          itemBuilder: (context, vin1)
          {
            return Card(
              margin: EdgeInsets.all(10),
              child: ListTile(

                //for updation
                onTap: ()
                {
    Navigator.push(context,
    MaterialPageRoute(builder: (context)=>enquiry_update(
        userdata[vin1]['enquiryid'],
      userdata[vin1]['enquiryname'],
      userdata[vin1]['enquirytype'],
       userdata[vin1]['enquirypincode'],
      userdata[vin1]['enquiryemail'],
      userdata[vin1]['enquiryphone'],
      userdata[vin1]['enquiryaddress'],
    ))
    );

                },

                leading: Icon(
                  CupertinoIcons.heart,
                  color: Colors.red,
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(userdata[vin1]['enquiryname']),
                    Text(userdata[vin1]['enquirytype']),
                    Text(userdata[vin1]['enquirypincode']),
                     Text(userdata[vin1]['enquiryemail']),
                     Text(userdata[vin1]['enquiryphone']),
                     Text(userdata[vin1]['enquiryaddress']),
                        Text(userdata[vin1]['enquirystatus']),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: ()
                  {
                    delrecord(userdata[vin1]['enquiryid']);
                  },
                ),
              ),
            );
          }
        ),









    );
  }
}

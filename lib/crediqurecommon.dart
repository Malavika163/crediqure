import 'dart:convert';
import 'package:crediqure/crediqurecommon_update.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:vscode/home/update_record.dart';
import 'package:http/http.dart' as http;

class Crediqurecommon extends StatefulWidget {
  const Crediqurecommon({super.key});

  @override
  State<Crediqurecommon> createState() => _view_dataState();
}

class _view_dataState extends State<Crediqurecommon> {
  List userdata=[];
  Future<void> delrecord(String id) async
  {
    try
    {
      String uri = "https://crediqure.com/appdevelopment/malavika/viewtable/delete_data_crediqurecommon.php";
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
          String uri = "https://crediqure.com/appdevelopment/malavika/viewtable/view_data_crediqurecommon.php";
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
     MaterialPageRoute(builder: (context)=>common_update(
         userdata[vin1]['commid'],
       userdata[vin1]['commhead'],
       userdata[vin1]['commdetails'],
       userdata[vin1]['commdate'],
       userdata[vin1]['commauthor'],
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
                    Text(userdata[vin1]['commhead']),
                    Text(userdata[vin1]['commdetails']),
                    Text(userdata[vin1]['commdate']),
                     Text(userdata[vin1]['commauthor']),
                     Text(userdata[vin1]['commstatus']),
                     Text(userdata[vin1]['commgmap']),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: ()
                  {
                    delrecord(userdata[vin1]['commid']);
                  },
                ),
              ),
            );
          }
        ),
 );
  }
}
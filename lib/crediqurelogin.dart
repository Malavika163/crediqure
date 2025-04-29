import 'dart:convert';
import 'package:crediqure/crediqurelogin_update.dart';
import 'package:crediqure/insert_crediqurelogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:vscode/home/update_record.dart';
import 'package:http/http.dart' as http;

class viewuser_data extends StatefulWidget {
  const viewuser_data({super.key});

  @override
  State<viewuser_data> createState() => _view_dataState();
}

class _view_dataState extends State<viewuser_data> {
  List userdata=[];
  Future<void> delrecord(String id) async
  {
    try
    {
      String uri = "https://crediqure.com/appdevelopment/malavika/viewtable/delete_data_crediqurelogin.php";
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
          String uri = "https://crediqure.com/appdevelopment/malavika/viewtable/view_data_crediqurelogin.php";
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
     MaterialPageRoute(builder: (context)=>login_update(
        userdata[vin1]['loginid'],
    userdata[vin1]['loginname'],
    userdata[vin1]['loginpassword'],
    userdata[vin1]['loginemail'],
    userdata[vin1]['loginphone'],
    userdata[vin1]['loginaddress'],
  
     ),
     ),
    );

                },

                leading: Icon(
                  CupertinoIcons.heart,
                  color: Colors.red,
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     Text(userdata[vin1]['loginid']),
                    Text(userdata[vin1]['loginname']),
                    Text(userdata[vin1]['loginpassword']),
                    Text(userdata[vin1]['logintype']),
                    Text(userdata[vin1]['loginstatus']),
                    Text(userdata[vin1]['loginemail']),
                    Text(userdata[vin1]['loginphone']),
                    Text(userdata[vin1]['loginaddress']),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: ()
                  {
                    delrecord(userdata[vin1]['loginid']);
                  },
                ),
              ),
            );
          }
        ),

       floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to your insert page here
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>InsertCrediqurelogin()
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),







    );
  }
}

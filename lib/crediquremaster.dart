import 'dart:convert';
import 'package:crediqure/crediqureloanmaster_update.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:vscode/home/update_record.dart';
import 'package:http/http.dart' as http;

class Crediquremaster extends StatefulWidget {
  const Crediquremaster({super.key});

  @override
  State<Crediquremaster> createState() => _view_dataState();
}

class _view_dataState extends State<Crediquremaster> {
  List userdata=[];
  Future<void> delrecord(String id) async
  {
    try
    {
      String uri = "https://crediqure.com/appdevelopment/malavika/viewtable/delete_data_crediqureloanmaster.php";
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
          String uri = "https://crediqure.com/appdevelopment/malavika/viewtable/view_data_crediqureloanmaster.php";
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
    MaterialPageRoute(builder: (context)=>loanmaster_update(
        userdata[vin1]['loanmasterid'],
                  userdata[vin1]['loantype'],
                    userdata[vin1]['loginid'],
                     userdata[vin1]['loandate'],
                     userdata[vin1]['loanstarted'],
                     userdata[vin1]['loanamount'],
                        userdata[vin1]['employeeid'],
                        userdata[vin1]['branchid'],
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
                    Text(userdata[vin1]['loanmasterid']),
                    Text(userdata[vin1]['loantype']),
                    Text(userdata[vin1]['loginid']),
                     Text(userdata[vin1]['loandate']),
                     Text(userdata[vin1]['loanstarted']),
                     Text(userdata[vin1]['loanamount']),
                        Text(userdata[vin1]['employeeid']),
                        Text(userdata[vin1]['branchid']),
                        Text(userdata[vin1]['loanstatus']),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: ()
                  {
                    delrecord(userdata[vin1]['loanmasterid']);
                  },
                ),
              ),
            );
          }
        ),









    );
  }
}

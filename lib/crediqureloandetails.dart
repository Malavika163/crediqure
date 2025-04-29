import 'dart:convert';
import 'package:crediqure/crediqureloandetail_update.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:vscode/home/update_record.dart';
import 'package:http/http.dart' as http;

class Crediqureloandetails extends StatefulWidget {
  const Crediqureloandetails({super.key});

  @override
  State<Crediqureloandetails> createState() => _view_dataState();
}

class _view_dataState extends State<Crediqureloandetails> {
  List userdata=[];
  Future<void> delrecord(String id) async
  {
    try
    {
      String uri = "https://crediqure.com/appdevelopment/malavika/viewtable/delete_data_crediqureloandetails.php";
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
          String uri = "https://crediqure.com/appdevelopment/malavika/viewtable/view_data_crediqureloandetails.php";
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
    MaterialPageRoute(builder: (context)=>loandetails_update(
        userdata[vin1]['loandetailsid'],
                    userdata[vin1]['masterid'],
                    userdata[vin1]['perticular'],
                     userdata[vin1]['amountpaid'],
                     userdata[vin1]['paymenttype'],
                     userdata[vin1]['remark'],
                        userdata[vin1]['dateopayment'],
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
                    Text(userdata[vin1]['loandetailsid']),
                    Text(userdata[vin1]['masterid']),
                    Text(userdata[vin1]['perticular']),
                     Text(userdata[vin1]['amountpaid']),
                     Text(userdata[vin1]['paymenttype']),
                     Text(userdata[vin1]['remark']),
                        Text(userdata[vin1]['dateopayment']),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: ()
                  {
                    delrecord(userdata[vin1]['loandetailsid']);
                  },
                ),
              ),
            );
          }
        ),









    );
  }
}

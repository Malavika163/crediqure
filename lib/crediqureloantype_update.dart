import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:vscode/home/update_record.dart';
import 'package:http/http.dart' as http;

class loantype_update extends StatefulWidget {
String id;
  String loantypename;
 
  loantype_update(this.id,this.loantypename, {super.key});

  @override
  State<loantype_update> createState() => _update_recordState();
}

class _update_recordState extends State<loantype_update>
{

  TextEditingController loantypeid=TextEditingController();
  TextEditingController loantypename=TextEditingController();
 

  Future <void> updaterecord() async
  {
    try
    {
      String uri = "https://crediqure.com/appdevelopment/malavika/viewtable/update_data_crediqureloantype.php";
      var res = await http.post(Uri.parse(uri),body:{
        "id":loantypeid.text,
        "loantypename":loantypename.text,
         
      });
      var response=jsonDecode(res.body);
      if(response["success"]=="true")
      {
        print("Record Updated");
        loantypeid.text="";
        loantypename.text="";
       
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
    loantypeid.text=widget.id;
    loantypename.text=widget.loantypename;
    
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
              controller: loantypeid,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
               
                
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: loantypename,
              
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                
                label: Text('Enter loantype'),
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

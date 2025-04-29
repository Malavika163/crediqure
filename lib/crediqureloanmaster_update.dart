import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class loanmaster_update extends StatefulWidget {
String id;
  String loantype;
  String loginid;
  String loandate;
   String loanstarted;
  String loanamount;
  String employeeid;
  String branchid;
  loanmaster_update(this.id,this.loantype,this.loginid,this.loandate,this.loanstarted,this.loanamount,this.employeeid,this.branchid, {super.key});

  @override
  State<loanmaster_update> createState() => _update_recordState();
}

class _update_recordState extends State<loanmaster_update>
{

  TextEditingController loanmasterid=TextEditingController();
  TextEditingController loantype=TextEditingController();
  TextEditingController loginid=TextEditingController();
  TextEditingController loandate=TextEditingController();
  TextEditingController loanstarted=TextEditingController();
  TextEditingController loanamount=TextEditingController();
  TextEditingController employeeid=TextEditingController();
TextEditingController branchid=TextEditingController();
  Future <void> updaterecord() async
  {
    try
    {
      String uri = "https://crediqure.com/appdevelopment/malavika/viewtable/update_data_crediqureloanmaster.php";
      var res = await http.post(Uri.parse(uri),body:{
        "id":loanmasterid.text,
        " loantype": loantype.text,
         "loandate":loandate.text,
         "loanstarted":loanstarted.text,
         "loanamount":loanamount.text,
         "employeeid":employeeid.text,
         " branchid": branchid.text,
      });
      var response=jsonDecode(res.body);
      if(response["success"]=="true")
      {
        print("Record Updated");
        loanmasterid.text="";
        loantype.text="";
        loandate.text="";
        loanstarted.text="";
        loanamount.text="";
        employeeid.text="";
        branchid.text="";
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
  {loanmasterid.text=widget.id;
     loantype.text=widget. loantype;
    loandate.text=widget.loandate;
     loanstarted.text=widget. loanstarted;
      loanamount.text=widget.  loanamount;
      employeeid.text=widget.employeeid;
     branchid.text=widget.branchid;
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
              controller: loanmasterid,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
               
                
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: loantype,
             
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                
                label: Text('Enter type'),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller:loginid,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter perticular'),
              ),
            ),
          ),


          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: loandate,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter loandate'),
              ),
            ),
          ),
           Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: loanstarted,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter started'),
              ),
            ),
          ),
           Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: loanamount,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter loanamount'),
              ),
            ),
          ),
           Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: employeeid,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter employee id'),
              ),
            ),
          ),
           Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: branchid,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter branch id id'),
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

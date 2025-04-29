import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class loandetails_update extends StatefulWidget {
String id;
  String masterid;
  String perticular;
  String amount;
   String type;
  String remark;
  String payment;
  loandetails_update(this.id,this.masterid,this.perticular,this.amount,this.type,this.remark,this.payment, {super.key});

  @override
  State<loandetails_update> createState() => _update_recordState();
}

class _update_recordState extends State<loandetails_update>
{

  TextEditingController loandetailsid=TextEditingController();
  TextEditingController masterid=TextEditingController();
  TextEditingController perticular=TextEditingController();
  TextEditingController amountpaid=TextEditingController();
  TextEditingController paymenttype=TextEditingController();
  TextEditingController remark=TextEditingController();
  TextEditingController dateopayment=TextEditingController();

  Future <void> updaterecord() async
  {
    try
    {
      String uri = "https://crediqure.com/appdevelopment/malavika/viewtable/update_data_crediqureloandetails.php";
      var res = await http.post(Uri.parse(uri),body:{
        "id":loandetailsid.text,
        "masterid":masterid.text,
         "perticular":perticular.text,
         "amount":amountpaid.text,
         "type":paymenttype.text,
         "remark":remark.text,
         "payment":dateopayment.text,
      });
      var response=jsonDecode(res.body);
      if(response["success"]=="true")
      {
        print("Record Updated");
        loandetailsid.text="";
        masterid.text="";
        perticular.text="";
        amountpaid.text="";
        paymenttype.text="";
        remark.text="";
        dateopayment.text="";
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
    loandetailsid.text=widget.id;
    masterid.text=widget.masterid;
    perticular.text=widget.perticular;
    amountpaid.text=widget.amount;
     paymenttype.text=widget.type;
     remark.text=widget.remark;
     dateopayment.text=widget.payment;
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
              controller: loandetailsid,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
               
                
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: masterid,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                
                //label: Text('Enter name'),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller:perticular,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter perticular'),
              ),
            ),
          ),


          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: amountpaid,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter amountpaid'),
              ),
            ),
          ),
           Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: paymenttype,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter paymenttype'),
              ),
            ),
          ),
           Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: remark,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter remark'),
              ),
            ),
          ),
           Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: dateopayment,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter Date of payment'),
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

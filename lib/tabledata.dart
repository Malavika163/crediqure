import 'package:crediqure/crediqurecommon.dart';
import 'package:crediqure/crediqureenquiry.dart';
import 'package:crediqure/crediqureloandetails.dart';
import 'package:crediqure/crediqureloantype.dart';
import 'package:crediqure/crediqurelogin.dart';
import 'package:crediqure/crediquremaster.dart';
import 'package:flutter/material.dart';



class TableScreen extends StatelessWidget {
  const TableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Database Table Display')),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Tables', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              title: Text('Crediqure login'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => viewuser_data())),
            ),

             ListTile(
              title: Text('Crediqure common'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Crediqurecommon())),
            ),
            
            ListTile(
              title: Text('Crediqure enquiry'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>Crediqureenquiry())),
            ),
            ListTile(
              title: Text('Crediqure loandetails'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>Crediqureloandetails())),
            ),
             ListTile(
              title: Text('Crediqure loanmaster'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>Crediquremaster())),
            ),
            ListTile(
              title: Text('Crediqure loantype'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>Crediqureloantype())),
            ),
          ],
        ),
      ),
      body: Center(child: Text('Welcome to Home Screen')),
    );
  }
}



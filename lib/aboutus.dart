import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us',style: TextStyle(color:Colors.white),),
        backgroundColor: Color(0xff800000),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: 'CREDI',
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff800000))),
                    TextSpan(
                        text: 'QURE',
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff111184))),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Who We Are',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff111184)),
            ),
            SizedBox(height: 10),
            Text(
              'CrediQure is a one-stop solution for all your gold loan needs. We are dedicated to making financial services more accessible, secure, and transparent. With cutting-edge technology and customer-centric values, we strive to make your loan process as seamless as possible.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              'Our Mission',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff800000)),
            ),
            SizedBox(height: 6),
            Text(
              'To provide easy, reliable, and doorstep financial solutions to our customers, ensuring trust, speed, and satisfaction.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Our Vision',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff800000)),
            ),
            SizedBox(height: 6),
            Text(
              'To become the most trusted gold loan partner across India, enabling financial independence for every household.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
            Text(
              'Why Choose Us?',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff111184)),
            ),
            SizedBox(height: 10),
            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.lock, color: Color(0xff800000)),
                  title: Text('Secure & Transparent Process'),
                ),
                ListTile(
                  leading: Icon(Icons.timer, color: Color(0xff800000)),
                  title: Text('Fast Loan Approvals'),
                ),
                ListTile(
                  leading: Icon(Icons.house, color: Color(0xff800000)),
                  title: Text('Doorstep Gold Loan Service'),
                ),
                ListTile(
                  leading: Icon(Icons.support_agent, color: Color(0xff800000)),
                  title: Text('24/7 Customer Support'),
                ),
              ],
            ),
            SizedBox(height: 30),
            Center(
              child: Text(
                'Thank you for choosing CrediQure!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xff111184)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

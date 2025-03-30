import 'package:crediqure/adressproof.dart';
import 'package:crediqure/editpassword.dart';
import 'package:crediqure/editprofile.dart';
import 'package:crediqure/services.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  final String vinid; 

  DashboardScreen({required this.vinid, super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: Colors.white),
        backgroundColor: Color(0xff800000),
        title: const Text('Dashboard', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome,",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "User ID: ${widget.vinid}", 
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  _buildDashboardCard("Edit Password", Icons.lock_outline, UpdatePasswordScreen(vinid: widget.vinid)),
                  _buildDashboardCard("View Services", Icons.design_services, LoanPage()),
                 // _buildDashboardCard("Edit Profile", Icons.person_outline, view_data()),
                  _buildDashboardCard("Edit Profile", Icons.person_outline, EditProfileScreen(vinid: widget.vinid)),
                  _buildDashboardCard("Address Proof", Icons.home_outlined, AddressProofUploadScreen()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(String label, IconData icon, Widget screen) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(icon, size: 40, color: Color(0xff800000)), SizedBox(height: 10), Text(label)],
        ),
      ),
    );
  }

}

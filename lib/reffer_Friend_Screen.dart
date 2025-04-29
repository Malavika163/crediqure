import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ReferFriendScreen extends StatefulWidget {
  const ReferFriendScreen({super.key});

  @override
  _ReferFriendScreenState createState() => _ReferFriendScreenState();
}

class _ReferFriendScreenState extends State<ReferFriendScreen> {
  void shareAppDetails() async {
    String shareText =
        "Check out this amazing gold loan app! Download it here: [Your App Store Link]";
    await Share.share(shareText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Refer a Friend", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xff800000),
        iconTheme: IconThemeData(color: Colors.white), // Back arrow white
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.group_add, size: 60, color: Color(0xff800000)),
                  SizedBox(height: 20),
                  Text(
                    "Invite your friends to try our Gold Loan app!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: shareAppDetails,
                    icon: Icon(Icons.share, color: Colors.white),
                    label: Text(
                      "Share App",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff800000),
                      padding: EdgeInsets.symmetric(
                          horizontal: 40, vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

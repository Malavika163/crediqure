import 'dart:convert';
import 'package:crediqure/aboutus.dart';
import 'package:crediqure/contactus.dart';
import 'package:crediqure/emergencyloan.dart';
import 'package:crediqure/goldcareScreen.dart';
import 'package:crediqure/goldloanscreen.dart';
import 'package:crediqure/homeloanScreen.dart';
import 'package:crediqure/personalScreen.dart';
import 'package:crediqure/propertyloan.dart';
import 'package:crediqure/termsandnorms.dart';
import 'package:crediqure/vehicleloan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:crediqure/login_screen.dart';
import 'package:crediqure/doorstep_gold_loan.dart';
import 'package:crediqure/goldloan_calculator.dart';
import 'package:crediqure/book_appointment.dart';
import 'package:crediqure/offer_screen.dart';
import 'package:crediqure/reffer_Friend_Screen.dart';
import 'package:crediqure/locateus.dart';


class CrediQureHomeScreen extends StatefulWidget {
  const CrediQureHomeScreen({super.key});
  @override
  State<CrediQureHomeScreen> createState() => _CrediQureHomeScreenState();
}

class _CrediQureHomeScreenState extends State<CrediQureHomeScreen> {
  List userdata = [];
  var datavalue = "";
  var datavalue1 = "";
  int activeIndex = 0;

  final List<String> images = [
    "data:image/jpeg;base64,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",
    "data:image/jpeg;base64,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",
    "data:image/jpeg;base64,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",
  ];

  final List<String> servicesoption = [
    'Gold Loan',
    'Gold Care',
    'Personal Loan',
    'Home Loan',
    'Vechicle Loan',
    'Property Loan',
    'Emergency Loan'
  ];

  final List<String> draweroption = ['About Us', 'Terms & Norms', 'Contact Us'];
  final List<IconData> drawericons = [
    Icons.group_outlined,
    Icons.menu_book_outlined,
    Icons.call,
  ];

  final List<String> quicklinks = [
    'Doorstep Gold Loan',
    'Gold Loan Calculator',
    'Book An Appointment',
    'Offers',
    'Refer A Friend',
    'Locate us'
  ];

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      String uri ="https://www.crediqure.com/appdevelopment/malavika/goldrate.php";
      var response = await http.post(Uri.parse(uri), body: {});
      var msg = jsonDecode(response.body);
      setState(() {
        datavalue = (msg['dataInfo']['3']);
        datavalue1 = (msg['dataInfo']['4']);
      });
    } catch (e) {
      print(e);
    }
  }

  void navigateToPage(BuildContext context, int index) {
    final List<Widget> quickLinkPages = [
      DoorstepGoldLoanScreen(),
      GoldLoanCalculator(goldPricePerGram: double.tryParse(datavalue1) ?? 0.0),
      BookAppointmentScreen(),
      OfferScreen(),
      ReferFriendScreen(),
      LocateUsPage(),
    ];

    if (index < quickLinkPages.length) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => quickLinkPages[index]),
      );
    }
  }

  void navigateToServicePage(int index) {
    final List<Widget> servicePages = [
      GoldLoanScreen(),
       GoldCareScreen(),
      PersonalLoanScreen(),
       HomeLoanScreen(),
      VehicleLoanScreen(),
       PropertyLoanScreen(),
      EmergencyLoanScreen(),
    ];

    if (index < servicePages.length) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => servicePages[index]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'CREDI',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff800000),
                ),
              ),
              TextSpan(
                text: 'QURE',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff111184),
                ),
              ),
            ],
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CrediqureLoginScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Color(0xff800000),
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [Icon(Icons.help), SizedBox(width: 5), Text('Help')],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [Icon(Icons.find_in_page), SizedBox(width: 5), Text("Careers")],
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Row(
                  children: [Icon(Icons.call), SizedBox(width: 5), Text("Contact")],
                ),
              ),
            ],
            onSelected: (value) {},
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color(0xff800000)),
              currentAccountPicture: ClipOval(
                child: Image.network(
                  'https://1.bp.blogspot.com/-Z-5oKsJ7NDw/WhWp1EqvswI/AAAAAAAARlo/rHSNKX-NVG8AGHsFgk52qWD7sABnkxTNACLcBGAs/s1600/53.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              accountName: Text('Malavika'),
              accountEmail: Text('malavika@gmail.com'),
            ),
            ListView.separated(
              shrinkWrap: true,
              itemCount: draweroption.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(drawericons[index]),
                  title: Text(
                    draweroption[index],
                    style: TextStyle(
                        color: Color(0xff111184), fontWeight: FontWeight.w700),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.pop(context);
                    switch (index) {
                      case 0:
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => AboutUsScreen()));
                        break;
                      case 1:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TermsAndNormsScreen()));
                        break;
                      case 2:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContactUsScreen()));
                        break;
                    }
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(color: Colors.grey);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              SizedBox(height: 10),
              CarouselSlider.builder(
                itemCount: images.length,
                itemBuilder: (context, index, realIndex) {
                  final image = images[index];
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 180,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
              AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: images.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: Color(0xff800000),
                  dotHeight: 10,
                  dotWidth: 10,
                ),
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xff800000),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Gold Rate Today",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 5),
                    Text("Max lending rate today: ₹$datavalue", style: TextStyle(fontSize: 16, color: Colors.white)),
                    Text("Our rate : ₹$datavalue1", style: TextStyle(fontSize: 16, color: Colors.white)),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: servicesoption.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => navigateToServicePage(index),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Color(0xff800000)),
                          color: Color(0xfffdebd0),
                        ),
                        child: Center(
                          child: Text(
                            servicesoption[index],
                            style: TextStyle(
                                color: Color(0xff800000), fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Quick Links",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff111184)),
                ),
              ),
              SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: quicklinks.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 3,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => navigateToPage(context, index),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff111184)),
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xffe8eaf6),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Center(
                        child: Text(
                          quicklinks[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xff111184), fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
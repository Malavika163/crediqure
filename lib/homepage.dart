import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:crediqure/book_appointment.dart';
import 'package:crediqure/doorstep_gold_loan.dart';
import 'package:crediqure/goldloan_calculator.dart';
import 'package:crediqure/locateus.dart';
import 'package:crediqure/login_screen.dart';
import 'package:crediqure/offer_screen.dart';
import 'package:crediqure/reffer_Friend_Screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CrediQureHomeScreen extends StatefulWidget {
  const CrediQureHomeScreen({super.key});

  @override
  State<CrediQureHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<CrediQureHomeScreen> {
  List userdata=[];
  var datavalue = "";
  var datavalue1="";
  

 
  

  bool isLoading = true; // Show loader initially
  String errorMessage = ""; // Store error messages

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  // Fetch user details using GET request
  Future<void> fetchUserData() async
  {
    try {
      String uri = "https://www.crediqure.com/appdevelopment/malavika/goldrate.php";
      var response = await http.post(Uri.parse(uri), body:
      {
      }
      );
      setState(()
      {
        var msg = jsonDecode(response.body);
       datavalue=(msg['dataInfo']['3']);
       datavalue1=(msg['dataInfo']['4']);

      });

    }
    catch(e)
    {
      print(e);
    }
  }

  int activeIndex = 0;

  final List<String> images = [
    
   "assets/gold3.jpg",
   "assets/image.jpg",
   "assets/gold1.jpg",
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

  final List<String> draweroption = [
    'About Us',
    'Terms & Norms',
    'Contact Us',
  ];

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

  void navigateToPage(BuildContext context, int index) {
  final List<Widget> quickLinkPages = [
     DoorstepGoldLoanScreen(),
     GoldLoanCalculator(),
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
                      color: Color(0xff800000))),
              TextSpan(
                  text: 'QURE',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff111184))),
            ],
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CrediqureLoginScreen())),
            child: Text(
              'Login',
              style: TextStyle(
                  color: Color(0xff800000),
                  fontWeight: FontWeight.w900,
                  fontSize: 18),
            ),
          ),
          SizedBox(width: 15),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(Icons.help),
                      SizedBox(width: 5),
                      Text('Help'),
                    ],
                  )),
              PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: [
                      Icon(Icons.find_in_page),
                      SizedBox(width: 5),
                      Text("Careers"),
                    ],
                  )),
              PopupMenuItem(
                  value: 3,
                  child: Row(
                    children: [
                      Icon(Icons.call),
                      SizedBox(width: 5),
                      Text("Contact"),
                    ],
                  )),
            ],
            onSelected: (value) {
              //Navigation
            },
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
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      'https://1.bp.blogspot.com/-Z-5oKsJ7NDw/WhWp1EqvswI/AAAAAAAARlo/rHSNKX-NVG8AGHsFgk52qWD7sABnkxTNACLcBGAs/s1600/53.jpg'),
                ),
                accountName: Text('Malavika'),
                accountEmail: Text('malavika@gmail.com')),
            ListView.separated(
              shrinkWrap: true,
              itemCount: draweroption.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(
                    drawericons[index],
                    //  Color(0xff111184),
                  ),
                  title: Text(
                    draweroption[index],
                    style: TextStyle(
                        color: Color(0xff111184), fontWeight: FontWeight.w700),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
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
              CarouselSlider.builder(
                  itemCount: images.length,
                  
                  itemBuilder: (context, index1, realIndex) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: Image.asset(
                          images[index1],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.25,
                      // autoPlay: true,
                      viewportFraction: 1,
                      enlargeCenterPage: true,
                      autoPlayInterval: Duration(seconds: 3),
                      onPageChanged: (index, reason) {
                        setState(() {
                          activeIndex = index;
                        });
                      })),
              SizedBox(height: 10),
              AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: images.length,
                effect: ExpandingDotsEffect(
                  radius: 20,
                  dotHeight: 7,
                  dotWidth: 8,
                  activeDotColor: Color(0xff800000),
                  dotColor: Colors.grey,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Services',
                    style: TextStyle(
                        color: Color(0xff111184),
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: servicesoption.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        
                        child: GestureDetector(
                          onTap: () => navigateToPage(context, index),
                          child: Container(
                            width: MediaQuery.of(context).size.height * 0.12,
                            height:0,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 220, 186, 98),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.blue, width: 2)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.attach_money_outlined),
                                Text(
                                  servicesoption[index],
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
                child: Container(
                  padding: EdgeInsets.only(left: 15),
                  height: 90,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xff800000),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Max lending rate today',
                        style: TextStyle(color: Colors.white),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.moving_sharp,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            '$datavalue',
                            style: TextStyle(color: Colors.white),
                          ),SizedBox(width:30,),
                           Row(
                             children: [
                               Text(
                                'Our Price :',
                                style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold),),
                                Text('$datavalue1',
                                style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold)),
                             ],
                           ),

                        ],
                      )
                    ],
                  ),
                ),
              ),
              // SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Quick Links',
                    style: TextStyle(
                        color: Color(0xff111184),
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SizedBox(
                  height: 300,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: quicklinks.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 140,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                       onTap: () => navigateToPage(context, index),

                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 220, 186, 98),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.blue, width: 2),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.attach_money_outlined),
                              Text(
                                quicklinks[index],
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

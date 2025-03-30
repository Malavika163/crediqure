import 'package:crediqure/enquiry.dart';
import 'package:flutter/material.dart';

class GoldLoanCalculator extends StatefulWidget {
   GoldLoanCalculator({super.key, datavalue});
//final Map<String, dynamic> msg = {'userInfo': {'1': 'Some user data',},  };

  @override
  _GoldLoanCalculatorState createState() => _GoldLoanCalculatorState();
}

class _GoldLoanCalculatorState extends State<GoldLoanCalculator> {
  final TextEditingController _weightController = TextEditingController();
  final double goldPricePerGram=65.7; 
  final double ltvPercentage = 75.0; 
  double? loanAmount;

  void calculateLoan() {
    double weight = double.tryParse(_weightController.text) ?? 0.0;
    if (weight > 0) {
      setState(() {
        loanAmount = (weight * goldPricePerGram * ltvPercentage) / 100;
      });
    } else {
      setState(() {
        loanAmount = null;
      });
    }
  }

  void applyForLoan() {
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text("Loan application submitted! Our team will contact you soon."),
    //     backgroundColor: Colors.green,
    //     duration: Duration(seconds: 2),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () {
      Navigator.pop(context); // This will navigate back
    },
  ),
        title: Text("Gold Loan Calculator",style:TextStyle(color: Colors.white),),
        backgroundColor: Color(0xff800000),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
           children: [
          //   Icon(
          //     Icons.gold,
          //     size: 80,
          //     color: Colors.amber,
          //   ),
            SizedBox(height: 20),
            Text(
              "Enter Gold Weight (grams)",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              onChanged: (value) => calculateLoan(),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                hintText: " enter gold weight in grams",
              ),
            ),
            SizedBox(height: 20),
            if (loanAmount != null)
              Column(
                children: [
                  Card(
                    elevation: 5,
                    color: Color(0xff800000),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      child: Column(
                        children: [
                          Text(
                            "Eligible Loan Amount",
                            style: TextStyle(fontSize: 18, color: Colors.white70),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "₹${loanAmount!.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => GoldLoanEnquiryScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff800000), 
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Apply for Loan",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

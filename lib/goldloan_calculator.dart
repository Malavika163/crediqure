import 'package:flutter/material.dart';
import 'package:crediqure/enquiry.dart';

class GoldLoanCalculator extends StatefulWidget {
   final double goldPricePerGram;
  const GoldLoanCalculator({super.key, required this.goldPricePerGram});
  

  @override
  _GoldLoanCalculatorState createState() => _GoldLoanCalculatorState();
}

class _GoldLoanCalculatorState extends State<GoldLoanCalculator> {
 final TextEditingController _weightController = TextEditingController();
  double? loanAmount;

  void calculateLoan() {
    double weight = double.tryParse(_weightController.text) ?? 0.0;
    if (weight > 0) {
      setState(() {
        loanAmount = (weight * widget.goldPricePerGram);
      });
    } else {
      setState(() {
        loanAmount = null;
      });
    }
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color:Colors.white,),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Gold Loan Calculator", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xff800000),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: "enter gold weight in grams",
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
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => GoldLoanEnquiryScreen( loanAmount: loanAmount, )));
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

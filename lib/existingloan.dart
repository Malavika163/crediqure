import 'dart:convert';
import 'package:crediqure/paymenthistory.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoanDetailsPage extends StatefulWidget {
  final String vinid;

  const LoanDetailsPage({super.key, required this.vinid});

  @override
  State<LoanDetailsPage> createState() => _LoanDetailsPageState();
}

class _LoanDetailsPageState extends State<LoanDetailsPage> {
  List userInfo1 = [];

  Future<void> Getrecord11() async {
    try {
      String uri1 =
          "https://www.crediqure.com/appdevelopment/malavika/existing_loan.php?vinid=${widget.vinid}";
      var response1 = await http.get(Uri.parse(uri1));
      setState(() {
        userInfo1 = jsonDecode(response1.body);
        print(userInfo1);
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    Getrecord11();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Loan Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff800000),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Display VIN ID
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.person,
                    color: Color(0xff111184),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'User id: ${widget.vinid}',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Loan List
            Expanded(
              child: userInfo1.isEmpty
                  ? const Center(child: Text("No loan records found."))
                  : ListView.builder(
                      itemCount: userInfo1.length,
                      itemBuilder: (context, index) {
                        final item = userInfo1[index];
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 4),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.badge,
                                      color: Color(0xff111184),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Loan ID: ${item['loanmasterid']}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),

                                // Info Rows
                                infoRow(Icons.account_balance, 'Loan Type',
                                    item['loantype']),
                                infoRow(Icons.person, 'Login ID',
                                    item['loginid']),
                                infoRow(Icons.calendar_month, 'Loan Date',
                                    item['loandate']),
                                infoRow(Icons.hourglass_bottom, 'Loan Started',
                                    item['loanstarted']),
                                infoRow(Icons.currency_rupee, 'Amount',
                                    item['loanamount']),

                                const SizedBox(height: 12),

                                // Button to repayment history
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RepaymentHistoryPage(
                                            loanId: item['loanmasterid'],
                                            loanamount: double.tryParse(
                                                    item['loanamount']) ??
                                                0.0,
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.history),
                                    label: const Text("Repayment History"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.indigo,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for a row with icon + label + value
  Widget infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[700]),
          const SizedBox(width: 8),
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Text(value, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}

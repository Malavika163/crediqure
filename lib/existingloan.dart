import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LoanDetailsPage extends StatelessWidget {
  final Map<String, dynamic> loan = {
    'loanId': 'LN123456',
    'borrowerName': 'John Doe',
    'amount': 50000.0,
    'interestRate': 5.5,
    'startDate': DateTime(2023, 1, 15),
    'endDate': DateTime(2028, 1, 15),
    'status': 'Active',
  };

  LoanDetailsPage({super.key});

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
        title: const Text('Loan Details',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor:  Color(0xff800000),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Center(
                  child: Text(
                    'Loan Summary',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff800000),
                    ),
                  ),
                ),
                const Divider(),
                const SizedBox(height: 10),
                DetailRow(icon: Icons.account_balance, label: 'Loan ID', value: loan['loanId']),
                DetailRow(icon: Icons.person, label: 'Borrower Name', value: loan['borrowerName']),
                DetailRow(icon: Icons.attach_money, label: 'Amount', value: '₹${loan['amount'].toStringAsFixed(2)}'),
                DetailRow(icon: Icons.percent, label: 'Interest Rate', value: '${loan['interestRate']}%'),
                DetailRow(icon: Icons.date_range, label: 'Start Date', value: DateFormat('dd MMM yyyy').format(loan['startDate'])),
                DetailRow(icon: Icons.event, label: 'End Date', value: DateFormat('dd MMM yyyy').format(loan['endDate'])),
                DetailRow(icon: Icons.info, label: 'Status', value: loan['status']),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const DetailRow({super.key, required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Color(0xff800000), size: 24),
          const SizedBox(width: 12),
          Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

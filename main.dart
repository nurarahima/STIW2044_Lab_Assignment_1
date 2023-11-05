import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoanCalculatorScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 100,
        ),
      ),
    );
  }
}

class LoanCalculatorScreen extends StatefulWidget {
  @override
  _LoanCalculatorScreenState createState() => _LoanCalculatorScreenState();
}

class _LoanCalculatorScreenState extends State<LoanCalculatorScreen> {
  double loanAmount = 10000;
  int loanTerm = 36;
  double interestRate = 5.0;
  double monthlyPayment = 0.0;

  void calculateMonthlyPayment() {
    double monthlyInterest = (interestRate / 12) / 100;
    int numberOfPayments = loanTerm * 12;
    monthlyPayment = (loanAmount * monthlyInterest) /
        (1 - pow(1 + monthlyInterest, -numberOfPayments));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Loan Amount'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                loanAmount = double.tryParse(value) ?? 0;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Loan Term (years)'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                loanTerm = int.tryParse(value) ?? 0;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Interest Rate (%)'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                interestRate = double.tryParse(value) ?? 0;
              },
            ),
            ElevatedButton(
              onPressed: () {
                calculateMonthlyPayment();
              },
              child: Text('Calculate'),
            ),
            Text('Monthly Payment: \$${monthlyPayment.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}

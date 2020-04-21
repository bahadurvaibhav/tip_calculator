import 'package:flutter/material.dart';

void main() => runApp(HomePage());

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final billController = TextEditingController();
  final tipPercentController = TextEditingController();

  double tipAmount = 0.0;
  double totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    billController.text = "0";
    tipPercentController.text = "15";
    billController.addListener(_calculateAmount);
    tipPercentController.addListener(_calculateAmount);
  }

  _calculateAmount() {
    double bill = 0.0;
    double tipPercent = 0.0;
    if (billController.text.isNotEmpty) {
      bill = double.parse(billController.text);
    }
    if (tipPercentController.text.isNotEmpty) {
      tipPercent = double.parse(tipPercentController.text);
    }

    setState(() {
      tipAmount = bill * (tipPercent / 100);
      totalAmount = bill + tipAmount;
    });
  }

  @override
  void dispose() {
    billController.dispose();
    tipPercentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tip Calculator'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(child: Text('Bill')),
                    Expanded(
                      child: TextFormField(
                        controller: billController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Expanded(child: Text('Tip %')),
                    Expanded(
                      child: TextFormField(
                        controller: tipPercentController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                ShowOutput(
                  tipAmount: tipAmount,
                  totalAmount: totalAmount,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShowOutput extends StatelessWidget {
  const ShowOutput({
    Key key,
    this.tipAmount,
    this.totalAmount,
  }) : super(key: key);

  final double tipAmount;
  final double totalAmount;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(child: Text('Tip Amount')),
            Expanded(child: Text(tipAmount.toStringAsFixed(2))),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: <Widget>[
            Expanded(child: Text('Total Amount')),
            Expanded(child: Text(totalAmount.toStringAsFixed(2))),
          ],
        )
      ],
    );
  }
}

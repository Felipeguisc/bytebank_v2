import 'package:bytebank_v2/models/balance.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BalanceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20.00),
        child: Consumer<Balance>(
          builder: (context, balance, child) {
            return Text(
              balance.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            );
          },
        ), //Text(balance.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

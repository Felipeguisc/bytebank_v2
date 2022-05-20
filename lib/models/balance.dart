import 'package:flutter/material.dart';

class Balance extends ChangeNotifier {
  double balance;

  Balance(this.balance);

  void add(double value){
    balance += value;

    notifyListeners();
  }

  void remove(double value){
    balance -= value;

    notifyListeners();
  }

  @override
  String toString() {
    return 'R\$ $balance';
  }
}
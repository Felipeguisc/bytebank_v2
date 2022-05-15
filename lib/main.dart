import 'package:bytebank_v2/screens/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BytebankApp());
}

class BytebankApp extends StatelessWidget {
  final ThemeData theme = ThemeData(
    primarySwatch: Colors.green,
    secondaryHeaderColor: Colors.green,
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.green[700],
      textTheme: ButtonTextTheme.primary,
    )
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: theme,
        home: const Dashboard()
    );
  }
}

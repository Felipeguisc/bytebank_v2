import 'dart:convert';

import 'package:http/http.dart';

import '../../models/transaction.dart';
import '../webclient.dart';

class TransactionWebClient {

  Future<List<Transaction>> findAll() async {
    final Response response = await client
        .get(Uri.http(baseUrl, 'transactions'))
        .timeout(const Duration(seconds: 5));
    List<Transaction> transactions = _toTransactions(response);
    return transactions;
  }

  Future<Transaction> save(Transaction transaction) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response = await client.post(
      Uri.http(baseUrl, 'transactions'),
      headers: {'Content-type': 'application/json', 'password': '1000'},
      body: transactionJson,
    );

    return _toTransaction(response);
  }

  List<Transaction> _toTransactions(Response response) {
    final List<dynamic> decoded = jsonDecode(response.body);
    final List<Transaction> transactions = decoded.map((dynamic json) {
      return Transaction.fromJson(json);
    }).toList();
    // final List<Transaction> transactions = [];
    // for (Map<String, dynamic> transactionJson in decoded) {
    //   transactions.add(Transaction.fromJson(transactionJson));
    // }
    return transactions;
  }

  Transaction _toTransaction(Response response) {
    return Transaction.fromJson(jsonDecode(response.body));
  }
}
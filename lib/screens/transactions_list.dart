import 'package:bytebank_v2/widgets/centered_message.dart';
import 'package:bytebank_v2/widgets/loading.dart';
import 'package:flutter/material.dart';

import '../api/webclients/transaction_webclient.dart';
import '../models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final TransactionWebClient _webclient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transações'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: _webclient.findAll(),
        builder: (context, snapshot) {

          switch(snapshot.connectionState){

            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const Loading();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if(snapshot.hasData){
                final List<Transaction>? transactions = snapshot.data;
                if(transactions!.isNotEmpty){
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Transaction transaction = transactions[index];
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.monetization_on),
                          title: Text(
                            transaction.value.toString(),
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            transaction.contact.accountNumber.toString(),
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: transactions.length,
                  );
                }
              }
              return CenteredMessage('Nenhuma transferência encontrada', icon: Icons.error);
          }
          return CenteredMessage('Erro desconhecido', icon: Icons.error);
        },
      ),
    );
  }
}
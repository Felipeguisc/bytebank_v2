import 'package:bytebank_v2/database/dao/contact_dao.dart';
import 'package:bytebank_v2/screens/contact_form.dart';
import 'package:bytebank_v2/screens/transaction_form.dart';
import 'package:bytebank_v2/widgets/loading.dart';
import 'package:flutter/material.dart';

import '../models/contact.dart';

class TransferContactsList extends StatefulWidget {
  @override
  State<TransferContactsList> createState() => _TransferContactsListState();
}

class _TransferContactsListState extends State<TransferContactsList> {

  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transferência'),
      ),
      body: FutureBuilder(
        initialData: const [],
        future: Future.delayed( const Duration(seconds: 1)).then((value) => _dao.findAll()),
        builder: (context, snapshot) {
          final contacts = (snapshot.data as List);
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const Loading();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              return ListView.builder(
                itemBuilder: (ctx, i) {
                  final Contact contact = contacts[i];
                  return _ContactItem(
                    contact,
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TransactionForm(contact),
                        ),
                      );
                    },
                  );
                },
                itemCount: contacts.length,
              );
          }
          return const Text(
              'Erro deconhecido, aguarde alguns instantes e tente novamente');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ContactForm(),
            ),
          ).then((value) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;
  final Function onClick;

  _ContactItem(
      this.contact, {
        required this.onClick,
      });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick(),
        title: Text(contact.name,
            style: const TextStyle(
              fontSize: 24,
            )),
        subtitle: Text(contact.accountNumber.toString(),
            style: const TextStyle(
              fontSize: 16,
            )),
      ),
    );
  }
}

import 'package:bytebank_v2/database/dao/contact_dao.dart';
import 'package:bytebank_v2/screens/contact_form.dart';
import 'package:bytebank_v2/widgets/loading.dart';
import 'package:flutter/material.dart';

import '../models/contact.dart';

class ContactsList extends StatefulWidget {
  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {

  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos'),
      ),
      body: FutureBuilder(
        initialData: const [],
        future: Future.delayed(const Duration(seconds: 1)).then((value) => _dao.findAll()),
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
                  return _ContactItem(contact);
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

  _ContactItem(this.contact);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
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

import 'package:bytebank_v2/models/contact.dart';
import 'package:flutter/material.dart';

import '../database/dao/contact_dao.dart';

class ContactForm extends StatefulWidget {

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();

  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nome completo',
              ),
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            TextField(
              controller: _accountNumberController,
              decoration: const InputDecoration(
                labelText: 'Número da Conta',
              ),
              style: const TextStyle(
                fontSize: 24,
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: false, signed: false),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: 1000.0,
                child: ElevatedButton(
                  onPressed: () {
                    final String name = _nameController.text;
                    final int? accountNumber = int.tryParse(_accountNumberController.text);

                    if(name != null && accountNumber != null){
                      final Contact newContact = Contact(0, name, accountNumber);
                      _dao.save(newContact).then((id) => Navigator.pop(context));
                    }
                  },
                  child: const Text('Salvar Contato'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

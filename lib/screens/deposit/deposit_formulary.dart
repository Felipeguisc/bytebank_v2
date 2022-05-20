import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/balance.dart';
import '../../widgets/editor.dart';
import '../transaction_form.dart';
import '../transfer.dart';

const String _appBarTitle = 'Receber Depósito';

const String _valueFieldTip = '0.00';
const String _valueFieldLabel = 'Valor';
const String _confirmButtonText = 'Confirmar';
const String _newTranferButtonText = 'Nova Tranferência';

class DepositFormulary extends StatelessWidget {
  final TextEditingController _valueFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Editor(
                tip: _valueFieldTip,
                label: _valueFieldLabel,
                icon: Icons.monetization_on,
                controller: _valueFieldController,
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _createDeposit(context),
                    child: const Text(_confirmButtonText),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return TransferContactsList();
                      }));
                    },
                    child: const Text(_newTranferButtonText),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _createDeposit(context) {
    final double? value = double.tryParse(_valueFieldController.text);

    if (_validateDeposit(value)) {
      _updateState(context, value);
      Navigator.pop(context);
    }
  }

  _validateDeposit(value) {
    final _fieldData = value != null;
    return _fieldData;
  }

  _updateState(context, value) {
    Provider.of<Balance>(context, listen: false).add(value);
  }
}

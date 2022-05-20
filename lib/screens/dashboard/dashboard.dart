import 'package:bytebank_v2/screens/contacts_list.dart';
import 'package:bytebank_v2/screens/deposit/deposit_formulary.dart';
import 'package:bytebank_v2/screens/transactions_list.dart';
import 'package:bytebank_v2/screens/transfer.dart';
import 'package:flutter/material.dart';

import '../../widgets/balance.dart';

const String _appBarLabel = 'Dashboard';
const String _logoPath = 'images/bytebank_logo.png';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        title: const Text(_appBarLabel),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              _logoPath,
              height: size.height / 3,
            ),
          ),
          BalanceCard(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _FeatureItem(
                  'Transferência',
                  Icons.monetization_on,
                  onTap: () => _showTransferContactsList(context),
                ),
                _FeatureItem(
                  'Extrato',
                  Icons.description,
                  onTap: () => _showTransactionsList(context),
                ),
                _FeatureItem(
                  'Contatos',
                  Icons.people,
                  onTap: () => _showContactsList(context),
                ),
                _FeatureItem(
                  'Depositar',
                  Icons.add_circle_outlined,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return DepositFormulary();
                      }),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showContactsList(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (context) => ContactsList(),
      ),
    );
  }

  void _showTransactionsList(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (context) => TransactionsList(),
      ),
    );
  }

  void _showTransferContactsList(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (context) => TransferContactsList(),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function onTap;

  _FeatureItem(this.label, this.icon, {required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onTap(),
          child: Container(
            padding: const EdgeInsets.all(8),
            height: 100,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
                Text(
                  label,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

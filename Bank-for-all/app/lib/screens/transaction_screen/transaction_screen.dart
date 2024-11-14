import 'package:bank_for_all/models/transaction/transaction.dart' as model;
import 'package:bank_for_all/services/transactions_service.dart';
import 'package:bank_for_all/utils/setup_locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bank_for_all/enums/transaction_type.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key key}) : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final _transactions = locator<TransactionService>();
  @override
  Widget build(BuildContext context) {
    final tabpages = <Widget>[
      Center(
        child: StreamBuilder(
          stream: _transactions.getDeposit(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              final deposit = snapshot.data.documents
                  .map((e) => model.Transaction.fromJson(e.data))
                  .toList();

              return ListView.builder(
                itemCount: deposit.length,
                itemBuilder: (context, index) {
                  return CListTile(
                    amount: deposit[index].amount,
                    date: dateformat(deposit[index].time),
                    account: deposit[index].narration,
                    icon: Icons.call_received,
                    color: Colors.green,
                  );
                },
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
      Center(
        child: StreamBuilder(
          stream: _transactions.getWithdraw(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              final withdraw = snapshot.data.documents
                  .map((e) => model.Transaction.fromJson(e.data))
                  .toList();

              return ListView.builder(
                itemCount: withdraw.length,
                itemBuilder: (context, index) {
                  return CListTile(
                    amount: withdraw[index].amount,
                    date: dateformat(withdraw[index].time),
                    account: withdraw[index].narration,
                    icon: Icons.call_made,
                    color: Colors.red,
                  );
                },
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    ];
    final tabs = <Tab>[
      Tab(text: "Deposit"),
      Tab(text: "Withdraw"),
    ];
    return SafeArea(
      child: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text("My Transactions"),
            bottom: TabBar(tabs: tabs),
          ),
          body: TabBarView(children: tabpages),
        ),
      ),
    );
  }

  String dateformat(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}

class CListTile extends StatelessWidget {
  const CListTile({
    Key key,
    @required this.amount,
    @required this.date,
    @required this.account,
    @required this.icon,
    @required this.color,
  }) : super(key: key);

  final String amount, date, account;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                amount,
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
              Text(
                "$date\n$account",
                style: TextStyle(color: Colors.black, fontSize: 22),
              ),
            ],
          ),
          Icon(
            icon,
            color: color,
            size: 40,
          ),
        ],
      ),
    );
  }
}

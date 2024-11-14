import 'package:bank_for_all/screens/transaction_screen/transaction_screen.dart';
import 'package:bank_for_all/services/user_service.dart';
import 'package:bank_for_all/utils/setup_locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/transaction/transaction.dart';
import '../../models/user/user.dart';

class AccountDetailScreen extends StatefulWidget {
  const AccountDetailScreen({Key key}) : super(key: key);
  @override
  _AccountDetailScreenState createState() => _AccountDetailScreenState();
}

class _AccountDetailScreenState extends State<AccountDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<DocumentSnapshot>(
          future: locator<UserService>().getUserData(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData) {
              final user = User.fromJson(snapshot.data.data);

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Semantics(
                    label: "Go back",
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                  const Center(
                    child: Text(
                      "User Account Details",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Account number:",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        Container(
                          width: 350,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            user.accountNumber,
                            style: TextStyle(fontSize: 35),
                          )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "IFSC number:",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        Container(
                          width: 350,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            user.ifscCode,
                            style: TextStyle(fontSize: 35),
                          )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Balance:",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        Container(
                          width: 350,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            user.balance,
                            style: TextStyle(fontSize: 35),
                          )),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Semantics(
                      label: "Go to transactions",
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TransactionScreen()));
                        },
                        child: Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadiusDirectional.circular(10)),
                          child: Center(
                            child: ExcludeSemantics(
                              child: Text(
                                "Okay",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

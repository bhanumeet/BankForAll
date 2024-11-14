import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../enums/transaction_type.dart';
import '../../models/transaction/transaction.dart';
import '../../models/user/user.dart';
import '../../services/transactions_service.dart';
import '../../services/user_service.dart';
import '../../utils/setup_locator.dart';
import '../payment_status/payment_status.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({
    Key key,
    @required this.vendorID,
    @required this.amount,
  }) : super(key: key);

  final String vendorID, amount;
  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final FlutterTts flutterTts = FlutterTts();

  var pssw = "1234";

  Future speak(String word) async {
    await flutterTts.setPitch(1);
    await flutterTts.speak(word);
  }

  int ctr = 0;

  final List<Widget> myDots = [];

  String _pin = "";

  final Container dot = Container(
    margin: const EdgeInsets.only(left: 15),
    width: 20,
    height: 20,
    decoration: BoxDecoration(
      color: Colors.black87,
      borderRadius: BorderRadius.circular(20),
    ),
  );

  void addDot(int number) {
    if (ctr < 4) {
      ctr++;
      myDots.add(dot);
      _pin += number.toString();
      speak("$number is added");
      if (_pin == pssw) {
        ifSuccess(context, widget.amount, widget.vendorID);
      }
    } else {
      ctr = 0;
      _pin = "";
      myDots.clear();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PaymentStatus(result: "Unsuccessful", ico: "cross"),
        ),
      );
    }
  }

  Future<void> ifSuccess(
    BuildContext context,
    String amount,
    String vendorID,
  ) async {
    final snap = await locator<UserService>().getUserData();

    final User user = User.fromJson(snap.data);

    final closingBal = int.parse(user.balance) - int.parse(amount);

    final hasBalance = closingBal > 0;

    if (hasBalance) {
      locator<TransactionService>().addTransaction(Transaction(
        closingBalance: closingBal.toString(),
        amount: widget.amount,
        narration: widget.vendorID,
        time: DateTime.now(),
        transactionType: TransactionType.withdraw,
      ));

      locator<UserService>().setUserData(User(
        accountNumber: user.accountNumber,
        address: user.address,
        balance: closingBal.toString(),
        firstName: user.firstName,
        lastName: user.lastName,
        gender: user.gender,
        gmail: user.gmail,
        id: user.id,
        ifscCode: user.ifscCode,
        phone: user.phone,
      ));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentStatus(
            result: "Successful",
            ico: "tick",
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PaymentStatus(result: "Unsuccessful", ico: "cross"),
        ),
      );
    }
    ctr = 0;
    _pin = "";
    myDots.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Semantics(
                  label: "Go back",
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Text(
                "Enter the Pin",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                ),
              ),
            ),
            Container(
              width: 350,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: myDots,
              ),
            ),
            /*1st number row*/
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                numberButton(1),
                numberButton(2),
                numberButton(3),
              ],
            ),

            /*2nd number row*/
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                numberButton(4),
                numberButton(5),
                numberButton(6),
              ],
            ),

            /*3rd number row*/
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                numberButton(7),
                numberButton(8),
                numberButton(9),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Semantics(
                  label: "Backspace",
                  child: InkWell(
                    onTap: () {
                      final len = _pin.length;
                      _pin = _pin.substring(0, len - 1);

                      ctr = len - 1;

                      setState(() {
                        myDots.removeLast();
                      });

                      speak("last number is removed");
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 30, bottom: 10),
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          color: Colors.blue[200],
                          borderRadius: BorderRadiusDirectional.circular(15)),
                      child: Icon(
                        Icons.backspace,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                numberButton(0),
                Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 10),
                  width: 80,
                  height: 80,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget numberButton(int number) {
    return Semantics(
      button: true,
      excludeSemantics: true,
      value: number.toString(),
      child: GestureDetector(
        onTap: () => setState(() => addDot(number)),
        child: Container(
          margin: const EdgeInsets.only(top: 30, bottom: 10),
          width: 80,
          height: 80,
          decoration:
              BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: Center(
            child: Text(
              number.toString(),
              style: const TextStyle(fontSize: 45),
            ),
          ),
        ),
      ),
    );
  }
}

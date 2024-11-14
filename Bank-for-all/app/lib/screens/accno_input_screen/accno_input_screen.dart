import 'package:bank_for_all/screens/pin_screen/pin_screen.dart';
import 'package:flutter/material.dart';

class AccnoInputScreen extends StatefulWidget {
  @override
  _AccnoInputScreenState createState() => _AccnoInputScreenState();
}

class _AccnoInputScreenState extends State<AccnoInputScreen> {
  int ctr = 0;

  final List<int> amount = [];

  String _pin = "";

  void addDot(int number) {
    if (ctr < 6) {
      ctr++;
      amount.add(number);
      _pin += number.toString();
      print(_pin);
    } else {
      ctr = 0;
      _pin = "";
      amount.clear();
    }
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
            Container(
              margin: EdgeInsets.only(bottom: 20),
              height: 40,
              width: 350,
              child: Center(
                child: Text(
                  "Enter the Account number",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Container(
              width: 350,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "$_pin",
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 5),
                        ),
                      ],
                    ),
                  ),
                  Semantics(
                      label: "Double tap to speak",
                      child: ExcludeSemantics(
                          child: Image.asset("assets/images/mic_icon.png"))
                          )
                ],
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                numberButton(0),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Semantics(
                  label: "Go to Pin input Screen",
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PinScreen()));
                    },
                    child: Container(
                      
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.blue[200], borderRadius: BorderRadiusDirectional.circular(15)),
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ],
            )
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
              style: const TextStyle(fontSize: 30),
            ),
          ),
        ),
      ),
    );
  }
}

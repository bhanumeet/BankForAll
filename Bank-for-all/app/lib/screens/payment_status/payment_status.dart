import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentStatus extends StatefulWidget {
  PaymentStatus({this.result, this.ico});
  String result, ico;
  @override
  _PaymentStatusState createState() => _PaymentStatusState();
}

class _PaymentStatusState extends State<PaymentStatus> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Center(
              child: Text(
                "Payment ${widget.result}",
                style: TextStyle(color: Colors.white, fontSize: 45),
                textAlign: TextAlign.center,
              ),
            ),
            ExcludeSemantics(
              child: Container(
                width: 300,
                height: 300,
                child: Image.asset("assets/images/${widget.ico}.png"),
              ),
            ),
            Semantics(
              label: "Go Home",
              child: InkWell(
                onTap: () =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
                child: Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(Icons.home, size: 40),
                ),
              ),
            ),
            if (widget.result == "Unsuccessful")
              Semantics(
                label: "Retry",
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(Icons.arrow_back_ios, size: 40),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

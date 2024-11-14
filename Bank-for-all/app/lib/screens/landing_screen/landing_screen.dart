import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'widgets/center_screen.dart';
import 'widgets/side_railing.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: <Widget>[
            const Expanded(
              flex: 2,
              child: CenterScreen(),
            ),
            const Expanded(
              child: SideRailing(),
            )
          ],
        ),
      ),
    );
  }
}

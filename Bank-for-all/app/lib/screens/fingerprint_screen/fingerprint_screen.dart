import 'package:flutter/material.dart';
import 'package:flutter_local_auth_invisible/flutter_local_auth_invisible.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../landing_screen/landing_screen.dart';

class FingerPrintScreen extends StatefulWidget {
  const FingerPrintScreen({Key key}) : super(key: key);

  @override
  _FingerPrintScreenState createState() => _FingerPrintScreenState();
}

class _FingerPrintScreenState extends State<FingerPrintScreen> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<void> _authenticateMe() async {
    bool authenticated = false;
    try {
      authenticated = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: "Authenticate for Testing", // message for dialog
        useErrorDialogs: true, // show error in dialog
        stickyAuth: true, // native process
      );
    } catch (e) {
      debugPrint(e.toString());
    }
    if (!mounted) return;

    if (authenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LandingScreen()),
      );
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      speak("authenticate with fingerprint to continue");
    });
  }

  final FlutterTts flutterTts = FlutterTts();
  Future speak(String word) async {
    await flutterTts.speak(word);
  }

  @override
  void initState() {
    super.initState();
    _authenticateMe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const ExcludeSemantics(
            child: Text(
              "Authenticate with fingerprint to continue",
              style: TextStyle(color: Colors.white, fontSize: 30),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          Icon(
            Icons.fingerprint,
            size: 80,
            color: Colors.white,
          ),
        ],
      )),
    );
  }
}

import 'package:flutter/material.dart';

import '../fingerprint_screen/fingerprint_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 300),
      () => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => const FingerPrintScreen())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: FlutterLogo(
            size: 80,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../services/auth_service.dart';
import '../../utils/setup_locator.dart';
import '../landing_screen/landing_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FlutterTts flutterTts = FlutterTts();

  Future speak(String word) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(word);
  }

  //   void initState(){
  //   super.initState();
  //   speak("To make payment, first tell us the receiver's number mentioned above the barcode. We'll repeat the number. Press middle of the screen to confirm. Press the upper right corner to restart transaction. Press the middle right corner to check your balance. Press the lower right corner for voice assistance to verify the payment. You can either use PIN or pattern verification to use PIN verification. Start typing your password with number five in middle of the screen. It's the only number that vibrates.Then you can proceed to enter your six digit pin like a normal keypad to use pattern verification. Setup your pattern by tapping one square at a time in a sequence that you like to setup your passwords. Please use assistance of a bank employee. Now your payment is made successfully.");
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Tooltip(
            message: "Login with google",
            child: InkWell(
              onTap: () => locator<AuthService>()
                  .signInWithGoogle()
                  .catchError((e) {})
                  .then(
                (value) {
                  if (value) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LandingScreen()),
                    );
                  }
                },
              ),
              borderRadius: BorderRadius.circular(30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  "assets/images/google_logo.jpg",
                  height: 100,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

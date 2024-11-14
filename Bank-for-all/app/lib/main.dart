import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'screens/fingerprint_screen/fingerprint_screen.dart';
import 'screens/login_screen/login_screen.dart';
import 'services/shared_prefs.dart';
import 'utils/setup_locator.dart';
import 'utils/theme.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bank for all',
      theme: theme,
      home: AnimatedSplashScreen.withScreenFunction(
        splash: "assets/images/mic_icon.png",
        centered: true,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.rightToLeftWithFade,
        curve: Curves.easeInExpo,
        backgroundColor: const Color(0xFF1A1A1A),
        screenFunction: () async {
          return locator<SharedPrefs>().getUser().then((value) {
            return locator<SharedPrefs>().authID == null
                ? const LoginScreen()
                : const FingerPrintScreen();
          });
        },
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: theme,
//       home: const TransactionScreen(),
//     );
//   }
// }

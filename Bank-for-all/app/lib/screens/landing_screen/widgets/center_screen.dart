import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_recognition/speech_recognition.dart';

import '../../amount_input_screen/amount_input_screen.dart';

class CenterScreen extends StatefulWidget {
  const CenterScreen({Key key}) : super(key: key);

  @override
  CenterScreenState createState() => CenterScreenState();
}

class CenterScreenState extends State<CenterScreen> {
  int ctr = 0;

  final FlutterTts flutterTts = FlutterTts();

  void resetVendor() {
    resultText = "";
  }

  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;
  String resultText = "";

  Future speak(String word) async {
    await flutterTts.setPitch(1);
    await flutterTts.speak(word);
  }

  @override
  void initState() {
    super.initState();

    _speechRecognition = SpeechRecognition();

    _speechRecognition.setRecognitionStartedHandler(
      () => setState(() => _isListening = true),
    );

    _speechRecognition.setRecognitionResultHandler(
      (String speech) => setState(() {
        resultText = speech;
      }),
    );

    _speechRecognition.setRecognitionCompleteHandler(
      () {
        setState(() => _isListening = false);
        Future.delayed(
          const Duration(milliseconds: 500),
          () async {
            await speak(resultText);
          },
        );
      },
    );

    _speechRecognition
        .activate()
        .then((result) => setState(() => _isAvailable = result as bool));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ExcludeSemantics(
                child: Text(
                  resultText,
                  style: const TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              Semantics(
                button: true,
                value: "Say vendor ID",
                sortKey: const OrdinalSortKey(0),
                child: GestureDetector(
                  onTap: () {
                    if (_isAvailable && !_isListening) {
                      _speechRecognition.listen(locale: "en_IN").then(
                        (result) {
                          print(result);
                        },
                      );
                    }
                  },
                  child: Image.asset("assets/images/mic_icon.png"),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Semantics(
              sortKey: const OrdinalSortKey(1),
              child: RaisedButton(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 20,
                ),
                color: Theme.of(context).buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                onPressed: () {
                  if (resultText.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AmountInputScreen(vendorID: resultText),
                      ),
                    );
                  } else {
                    speak(
                      "to proceed to pay say vendor id by pressing on center button and the confirm it",
                    );
                  }
                },
                child: const Text(
                  "Confirm",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

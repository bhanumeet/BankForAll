import 'package:bank_for_all/screens/accno_input_screen/accno_input_screen.dart';
import 'package:bank_for_all/screens/pin_screen/pin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_recognition/speech_recognition.dart';

class AmountInputScreen extends StatefulWidget {
  const AmountInputScreen({Key key, @required this.vendorID}) : super(key: key);

  final String vendorID;
  @override
  _AmountInputScreenState createState() => _AmountInputScreenState();
}

class _AmountInputScreenState extends State<AmountInputScreen> {
  int ctr = 0;

  final FlutterTts flutterTts = FlutterTts();

  void addDot(int number) {
    if (ctr < 6) {
      ctr++;

      resultText += number.toString();
      speak("$number was added");
    } else {
      ctr = 0;
      resultText = "";

      speak("Amount above 99999 should be made from bank only");
    }
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
      (String speech) => setState(() => resultText = speech),
    );

    _speechRecognition.setRecognitionCompleteHandler(
      () => setState(() {
        _isListening = false;
        Future.delayed(
          const Duration(milliseconds: 500),
          () async {
            await speak(resultText);
          },
        );
      }),
    );

    _speechRecognition
        .activate()
        .then((result) => setState(() => _isAvailable = result as bool));
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
              margin: const EdgeInsets.only(bottom: 20),
              height: 40,
              width: 350,
              child: Center(
                child: Text(
                  "Enter the Amount",
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
                          resultText,
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Semantics(
                    button: true,
                    label: "Say Amount",
                    child: InkWell(
                        onTap: () {
                          if (_isAvailable && !_isListening) {
                            _speechRecognition.listen(locale: "en_IN").then(
                                  (result) => print(result),
                                );
                          }
                        },
                        child: Image.asset("assets/images/mic_icon.png")),
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Semantics(
                  label: "Backspace",
                  child: InkWell(
                    onTap: () {
                      final len = resultText.length;
                      resultText = resultText.substring(0, len - 1);

                      ctr = len - 1;

                      setState(() {});

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
                Semantics(
                  label: "Confirm to enter pin",
                  child: InkWell(
                    onTap: () {
                      if (resultText.isNotEmpty && int.parse(resultText) > 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PinScreen(
                              vendorID: widget.vendorID,
                              amount: resultText,
                            ),
                          ),
                        );
                      } else {
                        speak("Enter some Amount");
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 30, bottom: 10),
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          color: Colors.blue[200],
                          borderRadius: BorderRadiusDirectional.circular(15)),
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                  ),
                ),
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

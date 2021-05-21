import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:http/http.dart' as http;
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'dart:io';
import 'package:Voice2Music/validation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

var ans;

class _MyHomeState extends State<MyHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {}

  String str = 'Tap to Search';
  bool _isListening = false;
  stt.SpeechToText _speech = stt.SpeechToText();
  String _text = 'Tap to Search';
  bool flag = false;
  bool show = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeef7fe),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        glowColor: Colors.blue[600],
        endRadius: 100.0,
        animate: _isListening,
        child: GestureDetector(
          onTap: () {
            _listen();
          },
          child: Material(
            shape: CircleBorder(),
            elevation: 8,
            child: Container(
              padding: EdgeInsets.all(10),
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue[600],
              ),
              child: Icon(
                Icons.mic,
                color: Colors.white,
                size: 45,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            WaveWidget(
              config: CustomConfig(
                colors: [
                  Colors.white70,
                  Colors.white54,
                  Colors.white30,
                  Colors.white24,
                ],
                durations: [32000, 21000, 18000, 5000],
                heightPercentages: [0.45, 0.46, 0.48, 0.51],
              ),
              backgroundColor: Colors.blue[600],
              size: Size(
                double.infinity,
                400,
              ),
            ),
            Container(
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffeef7fe),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 2.0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 290,
                    height: 50,
                    child: ListView(
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Text(
                          '$_text',
                          style: TextStyle(color: Colors.black, fontSize: 40),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    color: Colors.blue[600],
                    iconSize: 40,
                    onPressed: () async {
                      _checkConnection();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (_text == 'Tap to Search') {
          showDialog(
            context: context,
            builder: (BuildContext context) => emptyStringPopupDialog(context),
          );
        } else {
          var url = 'http://3.89.93.23/cgi-bin/spotifyAPI.py?x=$_text';

          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => SpinKitFadingCube(
                    color: Colors.blue,
                    size: 60,
                  ));
          var response = await http.get(url);
          Navigator.pop(context);
          print('Response body: ${response.body}');
          setState(() => ans = '${response.body}');
          if (ans == '') {
            showDialog(
              context: context,
              builder: (BuildContext context) => noMatchPopupDialog(context),
            );
          } else {
            Navigator.pushNamed(context, "/output");
          }
        }
      }
    } on SocketException catch (_) {
      showDialog(
        context: context,
        builder: (BuildContext context) => noInternetPopupDialog(context),
      );
    }
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            setState(() {
              _isListening = val.finalResult == true ? false : true;
            });
            str = 'Listening...';
          }),
        );
      }
    } else {
      setState(() {
        _isListening = false;
        str = 'Tap to Search';
      });
      _speech.stop();
    }
  }
}

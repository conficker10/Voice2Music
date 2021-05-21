import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'global.dart' as global;

class MyPlayer extends StatefulWidget {
  @override
  _MyPlayerState createState() => _MyPlayerState();
}

class _MyPlayerState extends State<MyPlayer> {
  AudioPlayer myPlayer = AudioPlayer();
  bool playPauseState = false;
  double values = 0;
  bool stateLoop = false;
  Duration _start = Duration(), _end = Duration();
  String position = "", duration = "", songName = "";
  bool songStop = false;
  void initState() {
    super.initState();
    myPlayer.setUrl(global.songURL);
    myPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        _end = d;
        duration = d.toString().split(".")[0];
        songName = global.songName + " - " + global.songArtist;
      });
    });

    myPlayer.onAudioPositionChanged.listen((Duration d) {
      setState(() {
        _start = d;
        position = d.toString().split(".")[0];
      });
    });

    myPlayer.onPlayerCompletion.listen((event) {
      myPlayer.onSeekComplete;
      setState(() {
        position = duration;
        playPauseState = false;
        if (stateLoop == true) {
          myPlayer.play(global.songURL);
          _start = Duration();
          playPauseState = true;
        }
      });
    });
  }

  @override
  void deactivate() {
    myPlayer.stop();
  }

  void myLoop() {
    if (stateLoop == false) {
      stateLoop = true;
      Fluttertoast.showToast(
          msg: "Loop Enabled",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.brown,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      stateLoop = false;
      Fluttertoast.showToast(
          msg: "Loop Disabled",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.brown,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void seekToSecond(int second) {
    Duration duration = Duration(seconds: second);
    myPlayer.seek(duration);
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.brown.shade100,
          appBar: AppBar(
            title: Text("Audio Player"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 350,
                  height: 350,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 40,
                        color: Colors.brown.shade300,
                      ),
                    ],
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(global.songImage)),
                    borderRadius: BorderRadius.circular(180),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.stop),
                        iconSize: 35,
                        onPressed: () {
                          Fluttertoast.showToast(
                              msg: "Music Stopped",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.brown,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          myPlayer.stop();
                          setState(() {
                            playPauseState = false;
                            songStop = true;
                            _start = Duration();
                            position = "";
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.fast_rewind),
                        iconSize: 35,
                        onPressed: () {
                          if (_start.inMilliseconds > 10000) {
                            Fluttertoast.showToast(
                                msg: "Rewind 10Sec",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.brown,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            myPlayer.seek(Duration(
                                milliseconds: _start.inMilliseconds - 10000));
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(
                            playPauseState ? Icons.pause : Icons.play_arrow),
                        iconSize: 35,
                        onPressed: () {
                          if (playPauseState == true) {
                            myPlayer.pause();
                            Fluttertoast.showToast(
                                msg: "Music Pause",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.brown,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            setState(() {
                              playPauseState = false;
                            });
                          } else {
                            Fluttertoast.showToast(
                                msg: "Music Play",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.brown,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            if (songStop == true) {
                              myPlayer.play(global.songURL);
                              _start = Duration();
                            } else {
                              myPlayer.resume();
                            }
                            setState(() {
                              playPauseState = true;
                            });
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.fast_forward),
                        iconSize: 35,
                        onPressed: () {
                          if (_start.inMilliseconds + 10000 <
                              _end.inMilliseconds) {
                            Fluttertoast.showToast(
                                msg: "Forward 10Sec",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.brown,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            myPlayer.seek(Duration(
                                milliseconds: _start.inMilliseconds + 10000));
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.loop),
                        iconSize: 35,
                        onPressed: myLoop,
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Text(songName),
                ),
                Slider(
                  value: _start.inSeconds.toDouble(),
                  min: 0,
                  max: _end.inSeconds.toDouble(),
                  onChanged: (double value) {
                    if (value < _end.inMilliseconds) {
                      setState(() {
                        seekToSecond(value.toInt());
                        value = value;
                      });
                    }
                  },
                ),
                Container(
                  margin: EdgeInsets.only(left: 25),
                  child: Row(
                    children: <Widget>[
                      Text(
                        position,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(" / "),
                      Text(
                        duration,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

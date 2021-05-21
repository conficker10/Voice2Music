import 'package:flutter/material.dart';
import 'package:Voice2Music/home.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'global.dart' as global;
import 'package:Voice2Music/validation.dart';

class MyOutput extends StatefulWidget {
  @override
  _MyOutputState createState() => _MyOutputState();
}

class _MyOutputState extends State<MyOutput> {
  Map data = json.decode(ans);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeef7fe),
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        title: Text("${data['Name']} - ${data['Artist']}"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  '${data['Image']}',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 650,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: FlatButton(
                      color: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      onPressed: () => {
                        global.songURL = '${data['Preview']}',
                        global.songName = '${data['Name']}',
                        global.songArtist = '${data['Artist']}',
                        global.songImage = '${data['Image']}',
                        if (global.songURL == 'null')
                          {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  noPreviewPopupDialog(context),
                            )
                          }
                        else
                          Navigator.pushNamed(context, "/player"),
                      },
                      child: new Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            child: new Text(
                              "Preview Song",
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold),
                            ),
                            padding: EdgeInsets.only(right: 5.0),
                          ),
                          new Image.asset(
                            'assets/images/preview.png',
                            height: 50.0,
                            width: 40.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: FlatButton(
                      color: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      onPressed: () {
                        _launchURL();
                      },
                      child: new Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            child: new Text(
                              "Open in YouTube",
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold),
                            ),
                            padding: EdgeInsets.only(right: 5.0),
                          ),
                          new Image.asset(
                            'assets/images/youtube.png',
                            height: 50.0,
                            width: 40.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              padding: EdgeInsets.only(bottom: 20.0),
            ),
          ],
        ),
      ),
    );
  }

  _launchURL() async {
    var url =
        'https://www.youtube.com//results?search_query=${data['Name']}+${data['Artist']}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
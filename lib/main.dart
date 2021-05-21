import 'package:Voice2Music/home.dart';
import 'package:Voice2Music/output.dart';
import 'package:Voice2Music/player.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => MyHome(),
        "/output": (context) => MyOutput(),
        "/player": (context) => MyPlayer(),
      },
    ),
  );
}

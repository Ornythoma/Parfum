import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';

import 'package:flutter_test_4/mainScreen.dart';


class EndScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EndState();
  }
}

class EndState extends State<EndScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initScreen(context),
    );
  }

  startTime() async {
    var duration = new Duration(seconds:1);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => MainScreen(),
    )
    );
  }

  initScreen(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset("images/smell.png"),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Text(
              "En cours d\'envoi...",
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.blueAccent
              ),
            ),
            Text(
              "Merci davoir participé",
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.blueAccent
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 1,
            )
          ],
        ),
      ),
    );
  }
}
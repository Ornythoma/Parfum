import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test_4/consentScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mainScreen.dart';
import 'package:geolocator/geolocator.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State<SplashScreen> {

  bool isConsentGiven = false;

  @override
  void initState() {
    super.initState();
    checkConsent();
    //sharedPrefInit();
    startTime();
  }


  Future<void> checkConsent() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool _consent = (pref.getBool('consent') ?? false);
    if (_consent) {
      setState(() {
        isConsentGiven = true;
        print('consent given');
      });
    } else {
      setState(() {
        isConsentGiven = false;
        print('consent NOT given');

      });
    }
  }

  // void sharedPrefInit() async {
  //   try {
  //     Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  //     final SharedPreferences prefs = await _prefs;
  //     prefs.getBool("consent");
  //
  //   } catch (err) {
  //     print("pas de prefs, switching straigth to report");
  //
  //     //// setMockInitialValues initiates shared preference
  //     //// Adds app-name
  //     // SharedPreferences.setMockInitialValues({});
  //     // Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  //     // final SharedPreferences prefs = await _prefs;
  //     // prefs.setString("Parfum", "my-app");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initScreen(context),
    );
  }

  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => isConsentGiven ? MainScreen() : ConsentScreen() )
    );
  }

  // TODO: ANIMATED ICON INSTEAD OF CIRCLE

  initScreen(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset("images/parfumIcon2.png"),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Text(
              "Splash Screen",
              style: TextStyle(fontSize: 20.0, color: Colors.white),
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

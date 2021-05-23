import 'package:flutter/material.dart';

import 'mainScreen.dart';
import 'consentScreen.dart';
import 'reportScreen.dart';
import 'SplashScreen.dart';
import 'endScreen.dart';


final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/': (BuildContext context) => SplashScreen(),
  '/consent': (BuildContext context) => ConsentScreen(),
  '/main': (BuildContext context) => MainScreen(),
  '/report': (BuildContext context) => Report(),
  '/endscreen': (BuildContext context) => EndScreen(),
};
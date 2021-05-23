import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

import 'mainScreen.dart';
import 'consentScreen.dart';
import 'reportScreen.dart';
import 'SplashScreen.dart';
import 'endScreen.dart';
import 'routes.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        routes: routes,
    );
  }
}

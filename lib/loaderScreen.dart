import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';

import 'mainScreen.dart';

class LoaderScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoaderState();
  }
}

class LoaderState extends State<LoaderScreen> {
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
    var duration = new Duration(seconds:6);
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
              child: Image.asset("assets/1_Palme_1_0.png"),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Text(
              "Splaaash",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white
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


// class LoaderScreen extends
// StatelessWidget {
//   @override
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("SmellLogger: Votre nez, votre futur!"),
//       ),
//       body: Column(
//         children: [
//           Text("LOADER"),
//           TextButton(
//             child: Text('Valider'),
//             style: TextButton.styleFrom(
//               side: BorderSide(
//                 color: Colors.grey,
//                 width: 1,
//               ),
//             ),
//             onPressed: () {
//               Navigator.pushNamed(
//                 context,
//                 '/consent',
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//

// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;
//
// import 'dart:convert';
//
// import 'smellSelect.dart';
// import 'report.dart';
//
//
//
// class Report extends StatefulWidget {
//   @override
//   _ReportState createState() => _ReportState();
// }
//
// //class _CustomSmellRadioState extends State<CustomSmellRadio> {
// class _ReportState extends State<Report> {
//
//   int _naturalnessValue = 0;
//
//   void _handleNaturalnessChange(int? value) {
//     if (value != null) {
//       setState(() {
//         _naturalnessValue = value;
//       });
//     }
//   }
//
//
//   Widget _buildLikertNaturalness() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         Container(
//           padding: const EdgeInsets.all(4),
//           child: Column(
//             children: [
//               Text('Très'),
//               Text('naturelle'),
//               Radio<int>(
//                 value: 1,
//                 groupValue: _naturalnessValue,
//                 onChanged: _handleNaturalnessChange,
//               ),
//             ],
//           ),
//         ),
//         Container(
//           padding: const EdgeInsets.all(4),
//           child: Column(
//             children: [
//               Text('Plutôt'),
//               Text('naturelle'),
//               Radio<int>(
//                 value: 2,
//                 groupValue: _naturalnessValue,
//                 onChanged: _handleNaturalnessChange,
//               ),
//             ],
//           ),
//         ),
//         Container(
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             children: [
//               Text('Ni naturelle'),
//               Text('ni artificielle'),
//               Radio<int>(
//                 value: 3,
//                 groupValue: _naturalnessValue,
//                 onChanged: _handleNaturalnessChange,
//               ),
//             ],
//           ),
//         ),
//         Container(
//           padding: const EdgeInsets.all(12),
//           child: Column(
//             children: [
//               Text('Plutôt'),
//               Text('artificielle'),
//               Radio<int>(
//                 value: 4,
//                 groupValue: _naturalnessValue,
//                 onChanged: _handleNaturalnessChange,
//               ),
//             ],
//           ),
//         ),
//         Container(
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             children: [
//               Text('Tres'),
//               Text('artificielle'),
//               Radio<int>(
//                 value: 5,
//                 groupValue: _naturalnessValue,
//                 onChanged: _handleNaturalnessChange,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   var _likertData = [
//     {
//       'question': 'L\'odeur est-elle agréable ou désagréable?',
//       'answers': [
//         'Très désagréable',
//         'Plutôt désagréable',
//         'Ni agréable ni désagréable',
//         'Plutôt agréable',
//         'Très agréable'
//       ],
//     },
//     {
//       'question': 'L\'odeur est-elle légère ou forte?',
//       'answers': [
//         'Très légère',
//         'Plutôt légère',
//         'Ni légère ni forte',
//         'Plutôt forte',
//         'Très forte'
//       ],
//     },
//     {
//       'question': 'L\'odeur est-elle naturelle ou artificielle?',
//       'answers': [
//         'Très naturelle',
//         'Plutôt naturelle',
//         'Ni naturelle ni artificielle',
//         'Plutôt artificielle',
//         'Très artificielle'
//       ],
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Report screen',
//       home: Scaffold(
//           appBar: AppBar(
//             title: Text('report screen'),
//           ),
//           body: SingleChildScrollView(
//             child: Column(
//               //  mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('L\'odeur est-elle...'),
//                 _buildLikertNaturalness(),
//                 Container(
//                   child: TextButton(
//                     child: Text('Valider'),
//                     onPressed: null,
//                   ),
//                 ),
//               ],
//             ),
//           )),
//     );
//   }
// }
//
// // Widget _buildLikert() {
// //   double _radioWidth = MediaQuery.of(context).size.width / 6.0;
// //   return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
// //     Container(
// //       padding: const EdgeInsets.all(4),
// //       child: Column(
// //         children: [
// //           Container(
// //             width: _radioWidth,
// //             child: new Column(
// //               children: <Widget>[
// //                 new Text("Très desagreable"),
// //               ],
// //             ),
// //           ),
// //           Radio<int>(
// //             value: 1,
// //             groupValue: _agreeablenessValue,
// //             onChanged: _handleAgreeablenessChange,
// //           ),
// //         ],
// //       ),
// //     ),
// //   ]);
// // }
//

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        questionText,
      ),
    );
  }
}

class Answer extends StatelessWidget {
  final Function selectHandler;
  final String answerText;

  Answer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        textColor: Colors.white,
        color: Colors.blue,
        child: Text(answerText),
        onPressed: null,
      ),
    );
  }
}


Future<Report> createReport(int timestamp, String smells, int agreeableness, int strength, int naturalness) async {
  final response = await http.post(
    Uri.https('html2json.com', '/api/v1'
        ''),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'timestamp': timestamp,
      'longitude': '',
      'latitude': '',
      'smells': smells,
      'agreeableness': agreeableness,
      'strength': strength,
      'naturalness': naturalness,
    }),
  );

  if (response.statusCode == 200) {
    return Report.fromJson(jsonDecode(response.body));
//    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to create report.');
  }
}

class Report {
  final int? id;
  final int? timestamp;
  final String? smells;
  final int? agreeableness;
  final int? strength;
  final int? naturalness;

  Report({this.id, this.timestamp, this.smells, this.agreeableness, this.strength, this.naturalness});

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      timestamp: json['timestamp'],
      smells: json['smells'],
      agreeableness: json['agreeableness'],
      strength: json['strength'],
      naturalness: json['naturalness'],
    );
  }
}



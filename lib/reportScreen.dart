import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'smellSelect.dart';
import 'report.dart';
import 'endScreen.dart';

class HttpService {
  Future<dynamic> sendRequestToServer(
      dynamic model, String reqType, bool isTokenHeader, String token) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest request = await client.postUrl(Uri.parse(
        "https://smell.me/$reqType")); //${serverConstants.serverUrl}$reqType
    request.headers.set('Content-Type', 'application/json');
    if (isTokenHeader) {
      request.headers.set('Authorization', 'Bearer $token');
    }
    request.add(utf8.encode(jsonEncode(model)));
    HttpClientResponse result = await request.close();
    if (result.statusCode == 200) {
      return jsonDecode(await result.transform(utf8.decoder).join());
    } else {
      return null;
    }
  }
}

class SmellRadioModel {
  bool isSelected;
  String smellText;

  SmellRadioModel(this.isSelected, this.smellText);
}

class SmellRadioItem extends StatelessWidget {
  final SmellRadioModel item;
  SmellRadioItem(this.item);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: item.smellText.length * 9.0,
      child: Container(
        child: Text(
          item.smellText,
          style: TextStyle(
            fontSize: 12,
            color: item.isSelected ? Colors.grey.shade50 : Colors.black54,
          ),
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: item.isSelected ? Colors.blueAccent : Colors.grey.shade50,
          border: Border.all(width: 0.2),
          boxShadow: item.isSelected
              ? [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(1, 1.5),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.all(Radius.circular(2)),
        ),
      ),
    );
  }
}

class SymptomRadioModel {
  bool isSelected;
  String symptomText;

  SymptomRadioModel(this.isSelected, this.symptomText);
}

class SymptomRadioItem extends StatelessWidget {
  final SymptomRadioModel item;
  SymptomRadioItem(this.item);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: item.symptomText.length * 9.0,
      child: Container(
        child: Text(
          item.symptomText,
          style: TextStyle(
            fontSize: 12,
            color: item.isSelected ? Colors.grey.shade50 : Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: item.isSelected ? Colors.blueAccent : Colors.grey.shade50,
          border: Border.all(width: 0.2),
          boxShadow: item.isSelected
              ? [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(1, 1.5),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.all(Radius.circular(2)),
        ),
      ),
    );
  }
}

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  List<SmellRadioModel> smellChoices = [];

  List<SymptomRadioModel> symptomChoices = [];
  int _durationValue = 0;
  int _physicalValue = 0;
  var _effect = [];
  String _comment = '';

  String _newSmell = '';

  var smells = [
    'fleurs',
    'égouts',
    'parfum',
    'herbe',
    'peinture',
    'chocolat',
    'pollution',
    'rivière',
    'lac',
    'fruits',
    'pourriture',
    'café',
    'animaux',
    'fleurs',
    'sueur',
    'cannabis',
    'fèces',
    'cannabis',
    'pâtisserie',
    'toilettes',
    'nourriture',
    'menthe',
    'fumée',
    'chimie',
    'fraise',
    'pain',
    'mauvaise haleine',
    'barbecue',
    'poussière',
    'fumée',
  ];

  var symptoms = [
    'aucun',
    'mal de tête',
    'confusion mentale',
    'mal de gorge',
    'nausées',
    'irritation du nez',
    'irritation des yeux',
    'nez qui coule',
    'toux',
    'éternuements',
    'difficulté à respirer',
    'maux d\'estomac',
    'difficulté à s\'endormir',
    'perte d\'appetit',
    'vomissements',
    'malaise',
  ];

  static const questions = [
    {
      'question': 'Depuis combien de temps sentez-vous cette odeur?',
      'answers': [
        '< 5 minutes',
        '< 15 minutes',
        '<1 heure',
        '> 1 heure',
      ],
    },
    {
      'question': 'Ressentez-vous des effets liés à cette odeur?',
      'answers': [
        'non, aucun',
        'mal de tête',
        'nausées',
        'irritations',
      ],
    },
  ];

  // Likert-scale variables and widgets
  int _agreeablenessValue = 0;
  int _strengthValue = 0;
  int _naturalnessValue = 0;
  int _healthinessValue = 0;

  List<Map<String, dynamic>> smell_questions = [
    {
      'question': 'L\'odeur est-elle légère ou forte?',
      'answers': [
        'Pas encore notée',
        'Très légère',
        'Plutôt légère',
        'Présente',
        'Plutôt forte',
        'Très forte'
      ],
    },
    {
      'question': 'L\'odeur est-elle désagréable ou agréable?',
      'answers': [
        'Pas notée',
        'Très désagréable',
        'Plutôt désagréable',
        'Ni agréable ni désagréable',
        'Plutôt agréable',
        'Très agréable'
      ],
    },
    {
      'question': 'L\'odeur est-elle naturelle ou artificielle?',
      'answers': [
        'Pas notée',
        'Très naturelle',
        'Plutôt naturelle',
        'Ni naturelle ni artificielle',
        'Plutôt artificielle',
        'Très artificielle'
      ],
    },
    {
      'question': 'L\'odeur est-elle plutôt bonne ou mauvaise pour la santé?',
      'answers': [
        'Pas notée',
        'Tres saine',
        'Plutot saine',
        'Ni saine ni malsaine',
        'Plutot malsaine',
        'Tres malsaine'
      ]
    }
  ];

  void _handleAgreeablenessChange(int? value) {
    if (value != null) {
      setState(() {
        _agreeablenessValue = value;
      });
    }
  }

  void _handleStrengthChange(int? value) {
    if (value != null) {
      setState(() {
        _strengthValue = value;
      });
    }
  }

  void _handleNaturalnessChange(int? value) {
    if (value != null) {
      setState(() {
        _naturalnessValue = value;
      });
    }
  }

  void _handleHealthinessChange(int? value) {
    if (value != null) {
      setState(() {
        _healthinessValue = value;
      });
    }
  }

  Widget _buildLikertStrength() {
    return Container(
      padding: new EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Text(smell_questions[0]['question'],
                    textAlign: TextAlign.start, style: TextStyle()),
              ),
            ],
          ),
          Wrap(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                child: Text(
                  smell_questions[0]['answers'][_strengthValue],
                  textAlign: TextAlign.start,
                  style: TextStyle(),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                // padding: const EdgeInsets.all(4),
                child: Column(
                  children: [
                    Radio<int>(
                      value: 1,
                      groupValue: _strengthValue,
                      onChanged: _handleStrengthChange,
                    ),
                  ],
                ),
              ),
              Container(
                // padding: const EdgeInsets.all(4),
                child: Column(
                  children: [
                    Radio<int>(
                      value: 2,
                      groupValue: _strengthValue,
                      onChanged: _handleStrengthChange,
                    ),
                  ],
                ),
              ),
              Container(
                // padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Radio<int>(
                      value: 3,
                      groupValue: _strengthValue,
                      onChanged: _handleStrengthChange,
                    ),
                  ],
                ),
              ),
              Container(
                // padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Radio<int>(
                      value: 4,
                      groupValue: _strengthValue,
                      onChanged: _handleStrengthChange,
                    ),
                  ],
                ),
              ),
              Container(
                // padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Radio<int>(
                      value: 5,
                      groupValue: _strengthValue,
                      onChanged: _handleStrengthChange,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLikertAgreeableness() {
    return Container(
      padding: new EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  smell_questions[1]['question'],
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          Wrap(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                child: Text(
                  smell_questions[1]['answers'][_agreeablenessValue],
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                // padding: const EdgeInsets.all(4),
                child: Column(
                  children: [
                    Radio<int>(
                      value: 1,
                      groupValue: _agreeablenessValue,
                      onChanged: _handleAgreeablenessChange,
                    ),
                  ],
                ),
              ),
              Container(
                // padding: const EdgeInsets.all(4),
                child: Column(
                  children: [
                    Radio<int>(
                      value: 2,
                      groupValue: _agreeablenessValue,
                      onChanged: _handleAgreeablenessChange,
                    ),
                  ],
                ),
              ),
              Container(
                // padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Radio<int>(
                      value: 3,
                      groupValue: _agreeablenessValue,
                      onChanged: _handleAgreeablenessChange,
                    ),
                  ],
                ),
              ),
              Container(
                // padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Radio<int>(
                      value: 4,
                      groupValue: _agreeablenessValue,
                      onChanged: _handleAgreeablenessChange,
                    ),
                  ],
                ),
              ),
              Container(
                // padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Radio<int>(
                      value: 5,
                      groupValue: _agreeablenessValue,
                      onChanged: _handleAgreeablenessChange,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLikertNaturalness() {
    return Container(
      padding: new EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  smell_questions[2]['question'],
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          Wrap(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                child: Text(
                  smell_questions[2]['answers'][_naturalnessValue],
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                // padding: const EdgeInsets.all(4),
                child: Column(
                  children: [
                    Radio<int>(
                      value: 1,
                      groupValue: _naturalnessValue,
                      onChanged: _handleNaturalnessChange,
                    ),
                  ],
                ),
              ),
              Container(
                // padding: const EdgeInsets.all(4),
                child: Column(
                  children: [
                    Radio<int>(
                      value: 2,
                      groupValue: _naturalnessValue,
                      onChanged: _handleNaturalnessChange,
                    ),
                  ],
                ),
              ),
              Container(
                // padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Radio<int>(
                      value: 3,
                      groupValue: _naturalnessValue,
                      onChanged: _handleNaturalnessChange,
                    ),
                  ],
                ),
              ),
              Container(
                // padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Radio<int>(
                      value: 4,
                      groupValue: _naturalnessValue,
                      onChanged: _handleNaturalnessChange,
                    ),
                  ],
                ),
              ),
              Container(
                // padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Radio<int>(
                      value: 5,
                      groupValue: _naturalnessValue,
                      onChanged: _handleNaturalnessChange,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLikertHealthiness() {
    return Container(
      padding: new EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  smell_questions[3]['question'],
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          Wrap(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                child: Text(
                  smell_questions[3]['answers'][_healthinessValue],
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                // padding: const EdgeInsets.all(4),
                child: Column(
                  children: [
                    Radio<int>(
                      value: 1,
                      groupValue: _healthinessValue,
                      onChanged: _handleHealthinessChange,
                    ),
                  ],
                ),
              ),
              Container(
                // padding: const EdgeInsets.all(4),
                child: Column(
                  children: [
                    Radio<int>(
                      value: 2,
                      groupValue: _healthinessValue,
                      onChanged: _handleHealthinessChange,
                    ),
                  ],
                ),
              ),
              Container(
                // padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Radio<int>(
                      value: 3,
                      groupValue: _healthinessValue,
                      onChanged: _handleHealthinessChange,
                    ),
                  ],
                ),
              ),
              Container(
                // padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Radio<int>(
                      value: 4,
                      groupValue: _healthinessValue,
                      onChanged: _handleHealthinessChange,
                    ),
                  ],
                ),
              ),
              Container(
                // padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Radio<int>(
                      value: 5,
                      groupValue: _healthinessValue,
                      onChanged: _handleHealthinessChange,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(
      height: 20,
      thickness: 2,
      indent: 60,
      endIndent: 60,
    );
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < smells.length; i++) {
      smellChoices.add(SmellRadioModel(false, smells[i]));
    }
    for (int i = 0; i < symptoms.length; i++) {
      symptomChoices.add(SymptomRadioModel(false, symptoms[i]));
    }
  }

  Widget _smellList() {
    return Column(children: [
      Container(
        padding: const EdgeInsets.fromLTRB(0, 5, 40, 4),
        child: Text(
          'Cliquez sur tous les mots correspondants à l\'odeur',
          softWrap: true,
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
//                height: 100,
          width: MediaQuery.of(context).size.width * 2,
          child: Wrap(
            children: [
              for (int i = 0; i < smellChoices.length; i++)
                GestureDetector(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
                      child: new SmellRadioItem(smellChoices[i]),
                    ),
                    onTap: () {
                      setState(() {
                        // TODO? : USE MODAL CLASS?
                        // smellChoices[i].isSelected = !smellChoices[i].isSelected;
                        smellChoices.forEach((element) {element.isSelected = false;});
                        smellChoices[i].isSelected = true;
                      });
                    }),
              // TODO: ajouter un mot
              GestureDetector(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
                    child: SizedBox(
                      width: 'Ajouter une odeur'.length * 9.0,
                      child: Container(
                        child: Text(
                          'Ajouter une odeur',
                          style: TextStyle(
                            fontSize: 12,
                            // color: item.isSelected ? Colors.grey.shade50 : Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          // color: item.isSelected ? Colors.blueAccent : Colors.grey.shade50,
                          border: Border.all(width: 0.2),
                          // boxShadow: item.isSelected
                          //     ? [
                          //         BoxShadow(
                          //           color: Colors.blueAccent.withOpacity(0.3),
                          //           spreadRadius: 2,
                          //           blurRadius: 3,
                          //           offset: Offset(1, 1.5),
                          //         ),
                          //       ]
                          //     : null,
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    _displaySmellInputDialog(context);
                  })
            ],
          ),
        ),
      ),
    ]);
    // TODO: FOCUS IS NOTHING SELECTED AT VALIDATION
  }

  Future<void> _displaySmellInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Textfield in dialog'),
            content: TextField(
              onChanged: (value) {
//                smellChoices.add(SmellRadioModel(true, value);
                valueSmellText = value;
              },
              controller: _smellTextFieldController,
              decoration: InputDecoration(hintText: "ecrivez quelques mots"),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    codeSmellDialog = valueSmellText;
                    smellChoices.forEach((element) {element.isSelected = false;});
                    smellChoices.add(SmellRadioModel(true, valueSmellText));
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  String codeSmellDialog = '';
  String valueSmellText = '';

  TextEditingController _smellTextFieldController = TextEditingController();

  Widget _symptomList() {
    return Column(children: [
      Container(
        padding: const EdgeInsets.fromLTRB(10, 5, 40, 4),
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
          child: Text(
            'Cliquez sur tous les mots correspondants àaux symptomes ressentis',
            softWrap: true,
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          padding: new EdgeInsets.all(10.0),
          child: SizedBox(
//        height: 100,
            width: MediaQuery.of(context).size.width * 2,
            child: Wrap(
              children: [
                for (int i = 0; i < symptomChoices.length; i++)
                  GestureDetector(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
                        child: new SymptomRadioItem(symptomChoices[i]),
                      ),
                      onTap: () {
                        setState(() {
                          symptomChoices[i].isSelected =
                              !symptomChoices[i].isSelected;
                        });
                      }),
                // TODO: ajouter un mot
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  final commentController = TextEditingController();

  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  // final Position _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  //
  // _getCurrentLocation() {
  //   Geolocator
  //     .getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true)
  //       .then((Position position) {
  //         setState(() {
  //           _currentPosition = position;
  //         });
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  // void getLocation() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.best,
  //   );
  //   print(position);
  // }
  //
  //
  // Future<Position> getPosition() async {
  //   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  //   print(position);
  //   return position;
  // }

  Future<http.Response> sendReport(String json) async {
    return http.post(Uri.parse('https://logair.eu/json_pg.php'),
        headers: {"Content-Type": "application/json"}, body: json);
  }

  void buildReport() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );

    var _listSmells = [];
    for (var key in smellChoices)
      if (key.isSelected) _listSmells.add(key.smellText);

    var _listSymptoms = [];
    for (var key in symptomChoices)
      if (key.isSelected) _listSymptoms.add(key.symptomText);

    Map jsonData = {
      'time': DateTime.now().millisecondsSinceEpoch,
      'longitude': position.longitude,//6.7484,
      'latitude': position.latitude,
      'xxx': position.altitude,
      'smells': _listSmells.toString(),
      'agreeableness': _agreeablenessValue,
      'strength': _strengthValue,
      'naturalness': _naturalnessValue,
      'healthiness': _healthinessValue,
      'duration': 0,
      'effects': _listSymptoms.toString(),
      'comment': commentController.text,
      'picture': ""
    };

    String body = jsonEncode(jsonData);
    print(body);

    Future<http.Response> resp = sendReport(body);
    //http.Response resp = await sendReport(body);

//    print(resp.headers);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => EndScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MaterialApp(
        title: 'Report screen',
        home: Scaffold(
            appBar: AppBar(
              title: Text('Décrire l\'odeur'),
            ),
            body: SingleChildScrollView(
              child: Column(
                //  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _smellList(),
                  _divider(),
                  Container(
                    padding: new EdgeInsets.all(10.0),
                    child: Text(
                      'Aidez-nous à comprendre cette odeur en répondant aux questions qui suivent:',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  _buildLikertStrength(),
                  _buildLikertAgreeableness(),
                  _buildLikertNaturalness(),
                  _buildLikertHealthiness(),
                  _divider(),
                  _symptomList(),
                  _divider(),
                  Container(
                    padding: EdgeInsets.all(12),
                    child: TextField(
                      maxLines: null, //null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Ajouter un commentaire',
                        hintText:
                            'Par exemple, dites-nous d\'ou l\'odeur vient',
                        // TODO: HINT ALEATOIRE
//                      isCollapsed: true,
                        isDense: true,
                        // contentPadding: EdgeInsets.all(8),
                      ),
                      controller: commentController,
                      // TODO: Defocus when touching somewhere else
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: TextButton(
                      child: Text('Valider'),
                      style: TextButton.styleFrom(
                        side: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      onPressed: () {
                        buildReport();
                      },
                    ),
                  ),
                ],
              ),
            )),
      ),
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }
}

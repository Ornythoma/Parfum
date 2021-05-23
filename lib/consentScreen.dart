import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ConsentScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ConsentScreenState();
}

class ConsentScreenState extends State<ConsentScreen> {
  @override
  bool consentResearch = false;
  bool consentOpen = false;
  bool consentGPS = false;

  bool consentData = false;

  var textSection = [
    'Cette application est offerte par l\'ACME. Elle sert à collecter des données anonymes sur les odeurs que nous rencontrons dans notre quotidien. Nous souhaitons pouvoir étudier les données dans le cadre d\'un projet universitaire, mais aussi en parler à la population en général. Pour en savoir plus sur ce que nous faisons, consultez notre site: logair.ch/odeurs',
    'Sur la base des informations qui précèdent, je confirme mon accord pour participer à cette recherche.',
  ];

  var consentTexts = [
    'J\'autorise l\'utilisation des données à des fins de scientifiques, incluant la publication des résultats de recherche dans des revues ou ouvrages scientifiques, ou à d\'autres fins comme leur diffusion sur notre site internet. Il est entendu que les données sont totalement anonymes et qu\'aucune information ne sera donnée sur mon identité',
    'Pour enregistrer un signalement, nous avons besoin de recueillir votre position GPS ainsi que la date et l\'heure, pour connaitre l\'endroit où et savoir quand vous signalez une odeur.',
  ];

  void printall() {
    print(consentResearch);
    print(consentOpen);
    print(consentGPS);
  }

  void _setConsentResearch(bool inp) {
    setState(() {
      consentResearch = inp;
    });
  }

  void _setConsentOpen(bool inp) {
    setState(() {
      consentOpen = inp;
    });
  }

  void _setConsentGPS(bool inp) {
    setState(() {
      consentGPS = inp;
    });
  }

  void _setConsentData(bool inp) {
    setState(() {
      consentData = inp;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _textSection = [
      'Cette application est offerte par l\'ACME. Elle sert à collecter des données anonymes sur les odeurs que nous rencontrons dans notre quotidien. Nous souhaitons pouvoir étudier les données dans le cadre d\'un projet universitaire, mais aussi en parler à la population en général. Pour en savoir plus sur ce que nous faisons, consultez notre site: logair.ch/odeurs',
      'Sur la base des informations qui précèdent, je confirme mon accord pour participer à cette recherche.',
      'Cette application est offerte par l\'ACME. Elle sert à collecter des données anonymes sur les odeurs que nous rencontrons dans notre quotidien. Nous souhaitons pouvoir étudier les données dans le cadre d\'un projet universitaire, mais aussi en parler à la population en général. Pour en savoir plus sur ce que nous faisons, consultez notre site: logair.ch/odeurs. Sur la base des informations qui précèdent, je confirme mon accord pour participer à cette recherche.',
    ];

    var _consentTexts = [
      'J\'autorise l\'utilisation des données à des fins de scientifiques et la publication des résultats de recherche dans des revues ou ouvrages scientifiques étant entendu que les données resteront anonymes et quaucune information ne sera donnée sur mon identité',
      'la publication des données à d\'autres fins non commerciales, comme leur diffusion sur notre site internet',
      'Pour enregistrer l\'endroit où vous signalez une odeur, nous avons besoin d\'obtenir votre position GPS. Autoriser l\'accès au GPS quand vous signalez une odeur?',
    ];

    var _data = 'Pour enregistrer un signalement, nous avons besoin de recueillir votre position GPS ainsi que la date et l\'heure, pour connaitre l\'endroit où et savoir quand vous signalez une odeur. Nous collectons aussi vos réponses au questionnaire qui suit, ainsi que vos commentaires écrits dans le champ libre.';

    var _consentIntro = [
      'J\'autorise l\'utilisation des données à des fins de scientifiques, incluant la publication des résultats de recherche dans des revues ou ouvrages scientifiques, ou à d\'autres fins comme leur diffusion sur notre site internet. Il est entendu que les données sont totalement anonymes et qu\'aucune information ne sera donnée sur mon identité',
    ];

    void _showConsentAlert() {
      Widget okButton = FlatButton(
        child: Text("Je comprends"),
        onPressed: () {
          Navigator.pop(context);
        },
      );

      AlertDialog alert = AlertDialog(
        title: Text("C'est embêtant..."),
        content: Text(
            "Sans votre consentement, nous ne pouvons vous aider à collecter des odeurs."),
        actions: [
          okButton,
        ],
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    Container _buildTextContainer(String text) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Text(
          text,
          softWrap: true,
        ),
      );
    }


    void setConsent() async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setBool('consent', true);
      print('setting consent true');
    }

    Color color = Theme.of(context).primaryColor;

    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Données et consentement'),
        ),
        body: ListView(
          children: [
            _buildTextContainer(_textSection[2]),
            _buildTextContainer(_data),
            Container(
//              padding: const EdgeInsets.all(0),
              child: Column(
                children: [
                  _buildTextContainer(_consentIntro[0]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        child: Text('NON'),
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          backgroundColor: Colors.red.shade50,
//                          elevation: 5,
                          side: BorderSide(
                            color: Colors.grey,
                            width: consentData ? 1 : 3,
                          ),
                        ),
                        onPressed: () {
                          _setConsentData(false);
                        },
                      ),
                      TextButton(
                        child: Text('OUI'),
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          backgroundColor: Colors.green.shade50,
                          side: BorderSide(
                            color: Colors.grey.shade600,
                            width: consentData ? 3 : 1,
                          ),
                        ),
                        onPressed: () {
                          _setConsentData(true);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              height: 10,
              thickness: 2,
              indent: 60,
              endIndent: 60,
            ),
            SizedBox(height: 40),
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
                  printall();
//                  if (consentGPS && consentOpen && consentResearch) {
                  if (consentData) {
                    setConsent();
                    Navigator.pushNamed(
                      context,
                      '/main',
                    );
                  } else {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) => Container(
                        // decoration: const BoxDecoration(
                        //   border: Border(top: BorderSide(color:Colors.black12)),
                        // ),
//                        height: 500,
                        child: new Wrap(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                    text:
                                        'Nous avons vraiment besoin de votre consentement!\n\n',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            'Puisque nous ne pouvons pas identifier vos soumissions une fois envoyées sur nos serveurs, il nous est impossible de les reconnaitre comme venant de vous.\n\n',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            'Parfum est un projet ouvert, qui espère vous aider à collecter des données qui serviront à rendre la ville meilleure. Pour nous laisser vous convaincre de participer, ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      TextSpan(
                                          text: 'rendez-nous visite!',
                                          style: TextStyle(
                                            color: Colors.blueAccent,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              launch('https://logair.io/');
                                            }),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

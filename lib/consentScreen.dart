import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ConsentScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ConsentScreenState();
}

class ConsentScreenState extends State<ConsentScreen> {
  @override

  bool consentResearch = false;
  bool consentOpen = false;
  bool consentGPS = false;

  var textSection = [
    'Cette application est offerte par l\'ACME. Elle sert à collecter des données anonymes sur les odeurs que nous rencontrons dans notre quotidien. Nous souhaitons pouvoir étudier les données dans le cadre d\'un projet universitaire, mais aussi en parler à la population en général. Pour en savoir plus sur ce que nous faisons, consultez notre site: logair.ch/odeurs',
    'Sur la base des informations qui précèdent, je confirme mon accord pour participer à cette recherche.',
  ];

  var consentTexts = [
    'J\'autorise l\'utilisation des données à des fins de scientifiques et la publication des résultats de recherche dans des revues ou ouvrages scientifiques étant entendu que les données resteront anonymes et quaucune information ne sera donnée sur mon identité',
    'la publication des données à d\'autres fins non commerciales, comme leur diffusion sur notre site internet',
    'Pour enregistrer l\'endroit où vous signalez une odeur, nous avons besoin d\'obtenir votre position GPS. Autoriser l\'accès au GPS quand vous signalez une odeur?',
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

    var _consentLackTexts = [
      'Sans ce consentement, nous ne pouvons pas publier nos efforts de recherche, ce qui nous rend triste',
      'Sans ce consentement, nous ne pouvons partager les odeurs que vous recueillez, et cela nous empêche de lutter pour changer les choses',
      'Sans ce consentement, nous ne pouvons savoir où vous êtes, et cela nous empêche de cartographier ce truc',
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
        content: Text("Sans votre consentement, nous ne pouvons vous aider à collecter des odeurs."),
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

    Container _buildConsentContainer(String text, bool consentType) {
      return Container(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Text(
              text,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: Text('NON'),
                  onPressed: () {
                    print('false');
                    // TODO: Find way to have a function receiving which consentType to set
                  },
                ),
                TextButton(
                  child: Text('OUI'),
                  onPressed: () {
                    print('TRUE');
                    print(consentType);
                    _setConsentResearch(true);
                    // TODO: Find generic way to do that.
                    // TODO: Find way to have a function receiving which consentType to set
                  },
                ),
              ],
            ),
          ],
        ),
      );
    }



    Color color = Theme.of(context).primaryColor;

    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Formulaire de consentement'),
        ),
        body: ListView(
          children: [
            _buildTextContainer(_textSection[2]),
            // _buildTextContainer(_textSection[0]),
            // _buildTextContainer(_textSection[1]),
//            _buildConsentContainer(consentTexts[0], consentResearch),
//            _buildConsentContainer(consentTexts[1], consentOpen),
//            _buildConsentContainer(consentTexts[2], consentGPS),
//             Divider(
//               height: 20,
//               thickness: 2,
//               indent: 60,
//               endIndent: 60,
//             ),
            Container(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  Text(
                    _consentTexts[0],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        child: Text('NON'),
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          backgroundColor: Colors.red.shade50,
                          side: BorderSide(
                            color: Colors.grey,
                            width: consentResearch ? 1 : 3,
                          ),
                        ),
                        onPressed: () {
                          print('false');
                          _setConsentResearch(false);
                        },
                      ),
                      TextButton(
                        child: Text('OUI'),
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          backgroundColor: Colors.green.shade50,
                          side: BorderSide(
                            color: Colors.grey,
                            width: consentResearch ? 3 : 1,
                          ),
                        ),
                        onPressed: () {
                          print('TRUE');
                          _setConsentResearch(true);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  Text(
                    _consentTexts[1],
                  ),
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
                            width: consentOpen? 1 : 3,
                          ),
                        ),
                        onPressed: () {
                          print('false');
                          _setConsentOpen(false);
                        },
                      ),
                      TextButton(
                        child: Text('OUI'),
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          backgroundColor: Colors.green.shade50,
                          side: BorderSide(
                            color: Colors.grey,
                            width: consentOpen? 3 : 1,
                          ),
//                          shadowColor: Colors.green,
//                          elevation: 5,
                        ),
                        onPressed: () {
                          print('TRUE');
                          _setConsentOpen(true);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  Text(
                    _consentTexts[2],
                  ),
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
                            width: consentGPS ? 1 : 3,
                          ),
                        ),
                        onPressed: () {
                          print('false');
                          _setConsentGPS(false);
                        },
                      ),
                      TextButton(
                        child: Text('OUI'),
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          backgroundColor: Colors.green.shade50,
                          side: BorderSide(
                            color: Colors.grey.shade600,
                            width: consentGPS ? 3 : 1,
                          ),
                        ),
                        onPressed: () {
                          print('TRUE');
                          _setConsentGPS(true);
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
                  if (consentGPS && consentOpen && consentResearch) {
                    print("OK");
                    Navigator.pushNamed(
                      context,
                      '/main',
                    );
                  } else {
//                _showConsentAlert();
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


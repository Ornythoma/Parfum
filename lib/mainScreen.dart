import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'main.dart';
import 'consentScreen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SmellLogger: Votre nez, votre futur!"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                child: Image.asset("images/smell.png", scale: 0.5,),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
                child: Text(
                    "Bienvenue sur Cart'Odeur! Vous sentez quelque chose? Appuyez sur le bouton ci-dessous."),

              ),
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.grey.shade600)
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/report');
                },
                child:
                  Text(
                    'Report',
                    style: TextStyle(fontSize: 24),
                  ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

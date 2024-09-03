import 'package:flutter/material.dart';
import 'package:tp/accueil.dart';
import 'package:tp/inscription.dart';
import 'package:tp/tiroir_nav.dart';

// TODO Un ecran minimal avec un tres peu de code
class Creation extends StatefulWidget {
  const Creation({super.key});

  @override
  State<Creation> createState() => _CreationState();
}

class _CreationState extends State<Creation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LeTiroir(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Création', style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0,150,0,40),
              child: Text('Création', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20,10,20,10),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nom'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20,10,20,10),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Date'
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(40,10,40,10),
              child: OutlinedButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Accueil(

                          )
                      )
                  );
                },
                child: const Text("Créer"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
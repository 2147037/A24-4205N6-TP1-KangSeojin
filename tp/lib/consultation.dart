import 'package:flutter/material.dart';
import 'package:tp/accueil.dart';
import 'package:tp/tiroir_nav.dart';

// TODO Un ecran minimal avec un tres peu de code
class Consultation extends StatefulWidget {
  const Consultation({super.key});

  @override
  State<Consultation> createState() => _ConsultationState();
}

class _ConsultationState extends State<Consultation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LeTiroir(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Consultation', style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(

        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0,150,0,40),
              child: Text('Détails', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20,10,20,10),
              child: TextField(
                controller: TextEditingController(text: "Tâche 0"),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nom'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20,10,20,10),
              child: TextField(
                controller: TextEditingController(text: "50%"),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Pourcentage d\'avancement'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20,10,20,10),
              child: TextField(
                controller: TextEditingController(text: "20%"),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Pourcentage de temps écoulé'
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
                child: const Text("Modifier"),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tp/accueil.dart';
import 'package:tp/lib_http.dart';
import 'package:tp/main.dart';
import 'package:tp/tiroir_nav.dart';
import 'package:tp/transfer.dart';

// TODO Un ecran minimal avec un tres peu de code
class Inscription extends StatefulWidget {
  const Inscription({super.key});


  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final nomController = TextEditingController();
  final pwController = TextEditingController();
  final confPwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Inscription', style: TextStyle(color: Colors.white),),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Container(
              height: 80,
            ),
            Container(
              height: 300,
              width: 400,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200)
              ),
              child: Center(
                child: Image.asset('asset/images/Logo.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20,10,20,10),
              child: TextField(
                controller: nomController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nom'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20,10,20,10),
              child: TextField(
                controller: pwController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20,10,20,10),
              child: TextField(
                controller: confPwController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Confirm Password'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40,10,40,10),
              child: OutlinedButton(
                onPressed: () async {
                  try {
                    SignupRequest request = SignupRequest(nomController.text, pwController.text);
                    var reponse = await signup(request);



                    print(reponse);
                  } catch(e){
                    print(e);
                    throw(e);
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Accueil(

                          )
                      )
                  );
                },
                child: const Text("Créer ton compte"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
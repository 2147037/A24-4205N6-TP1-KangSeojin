import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../models/transfer.dart';
import '../services/lib_http.dart';
import 'accueil.dart';

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
        title: Text(S.of(context).inscription, style: const TextStyle(color: Colors.white),),
      ),
      body: OrientationBuilder(
          builder: (context, orientation){
            if(orientation == Orientation.portrait){
              return _buildPortraitContainer(nomController: nomController, pwController: pwController, confPwController: confPwController);

            }
            else{
            return _buildPortraitContainer(nomController: nomController, pwController: pwController, confPwController: confPwController);
            }
          })
    );
  }
}

class _buildPortraitContainer extends StatelessWidget {
   _buildPortraitContainer({
    super.key,
    required this.nomController,
    required this.pwController,
    required this.confPwController,
  });

  final TextEditingController nomController;
  final TextEditingController pwController;
  final TextEditingController confPwController;

  final _formKeyName = GlobalKey<FormState>();
  final _formKeyPw = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    hintText: S.of(context).nom
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
                  hintText: S.of(context).password
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
                  hintText: S.of(context).confirmPassword
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40,10,40,10),
            child: OutlinedButton(
              onPressed: () async {
                if(pwController.text !=confPwController.text){
                  final snackBar = SnackBar(
                      content:  Text("Les mots de passe ne se concordent pas")
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  return;
                }

                try {
                  SignupRequest request = SignupRequest(nomController.text, pwController.text);
                  var reponse = await signup(request);



                  print(reponse);
                } catch(e){
                  if( e is DioException){
                    String errorMessage = e.response!.data.toString();
                    final snackBar = SnackBar(
                        content:  Text(errorMessage)
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  }
                  print(e.toString());

                  throw(e);
                }
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Accueil(

                        )
                    )
                );
              },
              child: Text(S.of(context).crerTonCompte),
            ),
          ),
        ],
      ),
    );
  }
}
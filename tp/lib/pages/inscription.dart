import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../generated/l10n.dart';
import '../models/transfer.dart';
import '../services/lib_http.dart';
import 'accueil.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

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

  bool finished =false;

  late SharedPreferences _prefs;
  String nomUtil = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    // TODO 1 Obtenir les préférences partagées
    // Attention, on obtient les préférence qu'une seule fois.
    // Si elles sont mises à jour par la suite, il faudra les obtenir à nouveau.
    _goodPrefs();
  }

  void _goodPrefs() async{
    _prefs = await SharedPreferences.getInstance();
    _obtenirPrefs();
  }


// TODO 2 Définir les préférences
  void _definirPrefs() {
    _prefs.setString('username', nomController.text);
    _prefs.setString('password', pwController.text);
    setState(() {
      nomUtil = nomController.text;
      password = pwController.text;
    });
  }

// TODO 3 Obtenir les préférences
  _obtenirPrefs() {
    setState(() {
      nomUtil = _prefs.getString('username') ?? '';
      password = _prefs.getString('password') ?? '';
    });
  }



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
              return _buildPortraitContainer(nomController: nomController, pwController: pwController, confPwController: confPwController, finished: finished,);

            }
            else{
            return _buildPortraitContainer(nomController: nomController, pwController: pwController, confPwController: confPwController, finished: finished,);
            }
          })
    );
  }
}
class _loading extends StatelessWidget{
  const _loading({
    super.key,
    required this.finished
  });

  final bool finished;

  @override
  Widget build(BuildContext context){
    return Center(
      child: Center(
        child: Container(
          height: 30,
          child: LoadingIndicator(
            colors: const [Colors.blue],
            indicatorType: Indicator.pacman ,
            strokeWidth: 3,
            pause: finished,
          ),
        ),
      ),
    );
  }
}

class _buildPortraitContainer extends StatelessWidget {
   _buildPortraitContainer({
    super.key,
    required this.nomController,
    required this.pwController,
    required this.confPwController,
     required this.finished
  });

  final TextEditingController nomController;
  final TextEditingController pwController;
  final TextEditingController confPwController;

  final _formKeyPw = GlobalKey<FormState>();

  final bool finished;




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
                bool isConnected = true;
                final listener = InternetConnection().onStatusChange.listen((InternetStatus status){
                  switch (status) {
                    case InternetStatus.connected:
                      isConnected = true;
                    break;
                    case InternetStatus.disconnected:
                      final snackBar = SnackBar(
                          content:  Text(S.of(context).laConnexionNestPasActive)
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      isConnected = false;
                    break;
                  }
                });

                if(isConnected ==false){
                  return;
                }

                if(pwController.text !=confPwController.text){
                  final snackBar = SnackBar(
                      content:  Text(S.of(context).lesMotsDePasseNeSeConcordentPas)
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return;
                }

                try {
                  ScaffoldMessenger.of(context).showMaterialBanner(
                    MaterialBanner(
                        content: _loading(finished: finished),
                        actions: <Widget>[
                          Text("")
                        ]
                    )
                  );
                  SignupRequest request = SignupRequest(nomController.text, pwController.text);
                  var reponse = await signup(request);
                  print(reponse);



                  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Accueil(prefs: _InscriptionState()._prefs,

                          )
                      )
                  );
                } catch(e){
                  if( e is DioException){
                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                    String errorMessage = e.response!.data.toString();
                    final snackBar = SnackBar(
                        content:  Text(errorMessage)
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  print(e.toString());
                  throw(e);
                }

              },
              child: Text(S.of(context).crerTonCompte),
            ),
          ),
        ],
      ),
    );
  }
}
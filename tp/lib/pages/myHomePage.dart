import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../generated/l10n.dart';
import '../models/transfer.dart';
import '../services/lib_http.dart';
import 'accueil.dart';
import 'inscription.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final nomController = TextEditingController();
  final pwController = TextEditingController();

  bool finished =false;

  late SharedPreferences _prefs;
  String nomUtil = '';
  String password = '';


  @override
  void initState() {
    super.initState();

    _goodPrefs();

    // Attention, on obtient les préférence qu'une seule fois.
    // Si elles sont mises à jour par la suite, il faudra les obtenir à nouveau.

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
_obtenirPrefs() async{

  nomUtil = _prefs.getString('username') ?? '';
  password = _prefs.getString('password') ?? '';
  if(nomUtil != '' && password!= '') {
    try {
      SignupRequest request = SignupRequest(nomUtil, password);
      var reponse = await signin(request);
      _definirPrefs();
      print("ADSADASDASDASDASDASDASDASDASDSADADDSA" + reponse.toString());
      finished = true;
      setState(() {});
    } catch (e) {
      if (e is DioException) {
        String errorMessage = e.response!.data.toString();
        final snackBar = SnackBar(
            content: Text(errorMessage)
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      throw(e);
    }
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Accueil(prefs: _prefs,)
        )
    );
  }
  else{
    finished = true;
    setState(() {});
  }
  setState(() {
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(S.of(context).connexion, style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: OrientationBuilder(
          builder: (context, orientation) {
            if(orientation == Orientation.portrait){
              return finished? _buildPortraitContainers(nomController: nomController, pwController: pwController, prefs: _prefs,) : _loading(finished: finished);

            }
            else{
              return finished? _buildPortraitContainers(nomController: nomController, pwController: pwController, prefs: _prefs,) : _loading(finished: finished);
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
            indicatorType: Indicator.ballPulse ,
            strokeWidth: 3,
            pause: finished,
          ),
        ),
      ),
    );
  }
}

class _buildPortraitContainers extends StatelessWidget {
   _buildPortraitContainers({
    super.key,
    required this.nomController,
    required this.pwController,
     required this.prefs,


  });

  final TextEditingController nomController;
  final TextEditingController pwController;
  final SharedPreferences prefs;


   void _definirPrefs() {
     prefs.setString('username', nomController.text);
     prefs.setString('password', pwController.text);
   }



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
                  hintText: S.of(context).nom,
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
            padding: const EdgeInsets.fromLTRB(40,10,40,10),
            child: OutlinedButton(
              onPressed: () async{
                bool bothGood = true;


                try {
                  SignupRequest request = SignupRequest(nomController.text, pwController.text);
                  var reponse = await signin(request);
                  print(reponse);
                  _definirPrefs();
                } catch(e){
                  if( e is DioException){
                    String errorMessage = e.response!.data.toString();
                    final snackBar = SnackBar(
                        content:  Text(errorMessage)
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  }
                  throw(e);
                }
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Accueil(prefs: prefs,)
                    )
                );
              },
              child: Text(S.of(context).connexion),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40,10,40,10),
            child: OutlinedButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Inscription(

                        )
                    )
                );
              },
              child: Text(S.of(context).inscription),

            ),
          ),
        ],
      ),
    );
  }
}

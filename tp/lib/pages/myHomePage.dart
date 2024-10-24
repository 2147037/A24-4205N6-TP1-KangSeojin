import 'package:flutter/material.dart';

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
              return _buildPortraitContainers(nomController: nomController, pwController: pwController);

            }
            else{
              return _buildPortraitContainers(nomController: nomController, pwController: pwController);

            }
          })
    );
  }
}

class _buildPortraitContainers extends StatelessWidget {
  const _buildPortraitContainers({
    super.key,
    required this.nomController,
    required this.pwController,
  });

  final TextEditingController nomController;
  final TextEditingController pwController;

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
            padding: const EdgeInsets.fromLTRB(40,10,40,10),
            child: OutlinedButton(
              onPressed: () async{
                try {
                  SignupRequest request = SignupRequest(nomController.text, pwController.text);
                  var reponse = await signin(request);
                  print(reponse);
                } catch(e){
                  print(e);
                  throw(e);
                }
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Accueil( )
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

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tp/main.dart';

import '../pages/accueil.dart';
import '../pages/creation.dart';
import '../pages/myHomePage.dart';
import '../services/lib_http.dart';


class LeTiroir extends StatefulWidget {
  const LeTiroir({super.key, required this.username , required this.prefs});

  final String username;
  final SharedPreferences prefs;

  @override
  State<LeTiroir> createState() => LeTiroirState();
}

class LeTiroirState extends State<LeTiroir> {
  @override
  Widget build(BuildContext context) {
    var listView = ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20,10,0),
          child: const DrawerHeader(

            child: Text('', style: TextStyle(color: Colors.black),),
            decoration: BoxDecoration(
              color: Colors.white60,
              image: DecorationImage(
                  image: AssetImage('asset/images/Logo.png'), fit: BoxFit.cover)
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0,10,0),
          child: Text('Bonjour ' + widget.username + '!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        ),
        ListTile(
          dense: true,
          leading: const Icon(Icons.home_filled),
          title: const Text("Accueil"),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Accueil(prefs: widget.prefs,),
              ),
            );
          },
        ),

        ListTile(
          dense: true,
          leading: const Icon(Icons.add),
          title: const Text("Ajout de tâche"),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Creation(prefs: widget.prefs,),
              ),
            );
          },
        ),
        ListTile(
          dense: true,
          leading: const Icon(Icons.logout),
          title: const Text("Déconnexion"),
          onTap: () async{
            try {
              var reponse = await signout();
              print(reponse);
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHomePage(title: "title"),
                  ),
              );

              widget.prefs.clear();
            } catch(e){
              print(e);
              throw(e);
            }
          },
        ),
      ],
    );

    return Drawer(
      child: Container(
        color: const Color(0xFFFFFFFF),
        child: listView,
      ),
    );
  }
}
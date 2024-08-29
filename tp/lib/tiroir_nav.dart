import 'package:flutter/material.dart';
import 'package:tp/inscription.dart';
import 'package:tp/main.dart';


class LeTiroir extends StatefulWidget {
  const LeTiroir({super.key});

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
        ListTile(
          dense: true,
          leading: const Icon(Icons.account_circle_outlined),
          title: const Text("Connexion"),
          onTap: () {
            // TODO ferme le tiroir de navigation
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyHomePage(title: "title"),
              ),
            );
            // Then close the drawer
          },
        ),

        // TODO le tiroir de navigation ne peut pointer que vers des
        // ecran sans paramtre.
        ListTile(
          dense: true,
          leading: const Icon(Icons.account_circle),
          title: const Text("Inscription"),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Inscription(),
              ),
            );
            // Then close the drawer
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
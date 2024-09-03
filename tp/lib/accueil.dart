import 'package:flutter/material.dart';
import 'package:tp/tiroir_nav.dart';

// TODO Un ecran minimal avec un tres peu de code
class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  List<String> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for(int i =0; i < 30; i++){
      items.add('Tâche ' + i.toString());
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LeTiroir(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Accueil', style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: items.map((item) {
          return Card(
            color: Colors.cyan,
              child: ListTile(
                leading: Icon(Icons.task),
                title: Text(item, style: TextStyle(color: Colors.black),),
                trailing: IconButton(onPressed: (){}, icon: Icon(Icons.add)),
            )
          );
        }).toList(),

        ),
    );
  }
}
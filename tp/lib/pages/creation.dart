import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transfer.dart';
import '../services/lib_http.dart';
import '../widgets/tiroir_nav.dart';
import 'accueil.dart';

// TODO Un ecran minimal avec un tres peu de code
class Creation extends StatefulWidget {
  const Creation({super.key});

  @override
  State<Creation> createState() => _CreationState();
}

class _CreationState extends State<Creation> {
  final TextEditingController dateController = TextEditingController();
  final nomController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LeTiroir(username: SignletonDio.username),
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
                controller: nomController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nom'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25,10,25,10),
              child: TextField(
                controller: dateController,
                decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Entrer la date",
                ),
              readOnly: true,
                onTap: () async{
                      DateTime? pickedDate = await showDatePicker(context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2024),
                      lastDate: DateTime(2100)
                  );
                      if(pickedDate!= null){
                        String formattedDate = DateFormat("yyyy-MM-dd").format(pickedDate);

                        setState(() {
                          dateController.text= formattedDate.toString();
                        });
                      }
                      else{

                      }
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(40,10,40,10),
              child: OutlinedButton(
                onPressed: ()async{
                  try {
                    AddTaskRequest request = AddTaskRequest(nomController.text, DateTime.parse(dateController.text));
                    var reponse = await add(request);
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
                child: const Text("Créer"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
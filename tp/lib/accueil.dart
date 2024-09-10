import 'package:flutter/material.dart';
import 'package:tp/consultation.dart';
import 'package:tp/creation.dart';
import 'package:tp/lib_http.dart';
import 'package:tp/tiroir_nav.dart';
import 'package:tp/transfer.dart';

// TODO Un ecran minimal avec un tres peu de code
class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  List<HomeItemResponse> items = [];


  @override
  void initState() {
    // TODO: implement initStat
    try {
      home().then((reponse) {
        print(reponse);
        items = reponse;
        setState(() {});
      },);


    } catch(e){
      print(e);
      throw(e);
    }


    setState(() {

    });
    super.initState();


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
                title: Row(
                  children: <Widget>[
                    Container(
                      child: Text(item.name +"\nDeadline : "+
                                  item.deadline.toString() +"\nPercentage Done : " +
                                  item.percentageDone.toString() +"\nPercentage Time Spent : " +
                                  item.percentageTimeSpent.toString(),style: TextStyle(fontSize: 15),) ,
                    ),

                  ],
                ),

                
                
                trailing: IconButton(onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Consultation(
                          )
                      )
                  );
                },
                    icon: Icon(Icons.info_outline_rounded)),
            ),
          );

        }).toList(),

        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Creation(
                  )
              )
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tp/consultation.dart';
import 'package:tp/creation.dart';
import 'package:tp/lib_http.dart';
import 'package:tp/tiroir_nav.dart';
import 'package:tp/transfer.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
      drawer: LeTiroir(username:  SignletonDio.username),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Accueil', style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: items.map((item) {
          String formattedDate = DateFormat("yyyy-MM-dd").format(item.deadline);

          return Card(
            color: Colors.cyan,
              child: ListTile(
                leading: Icon(Icons.task),
                title: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10,0,0,5),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          item.name +"\nDeadline : " + formattedDate ,style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,) ,
                      ),
                    ),
                    LinearPercentIndicator(
                      animation: true,
                      animationDuration: 1000,
                      lineHeight: 20.0,
                      percent: item.percentageDone/100,
                      center: Text(
                          "Percentage Done - " +item.percentageDone.toString() + "%",
                          style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          )
                      ),
                    ),
                    Container(
                      height: 6,
                    ),
                    LinearPercentIndicator(
                      animation: true,
                      animationDuration: 1000,
                      lineHeight: 20.0,
                      percent: item.percentageTimeSpent/100,
                      center: Text(
                          "Percentage Time Spent - " +item.percentageTimeSpent.toString() + "%",
                          style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          )
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(onPressed: () async{
                  try {

                    var reponse = await detail(item.id);
                    print(reponse);
                    TaskDetailResponse taskDetailResponse = reponse;
                    print(taskDetailResponse);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Consultation(
                                tdr: taskDetailResponse
                            )
                        )
                    );
                  } catch(e){
                    print(e);
                    throw(e);
                  }

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
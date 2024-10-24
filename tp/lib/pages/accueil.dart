import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../generated/l10n.dart';
import '../models/transfer.dart';
import '../services/lib_http.dart';
import '../widgets/tiroir_nav.dart';
import 'consultation.dart';
import 'creation.dart';

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
        title:  Text(S.of(context).accueil, style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: OrientationBuilder(
          builder: (context,orientation){
            if(orientation == Orientation.portrait){
              return _builderPortraitContainers(items: items);
            }
            else{
              return _builderPortraitContainers(items: items);
            }
          }),
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

class _builderPortraitContainers extends StatelessWidget {
  const _builderPortraitContainers({
    super.key,
    required this.items,
  });

  final List<HomeItemResponse> items;

  @override
  Widget build(BuildContext context) {
    return ListView(
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
                        item.name +"\n"+S.of(context).deadline +" : "+ formattedDate ,style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,) ,
                    ),
                  ),
                  LinearPercentIndicator(
                    animation: true,
                    animationDuration: 1000,
                    lineHeight: 20.0,
                    percent: item.percentageDone/100,
                    center: Text(
                        S.of(context).percentageDone + " - " +item.percentageDone.toString() + "%",
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
                        S.of(context).percentageTimeSpent + " - " +item.percentageTimeSpent.toString() + "%",
                        style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        )
                    ),
                  ),
                  (item.photoId !=0)?
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network("http://10.0.2.2:8080/file/" + item.photoId.toString(), width: 200, height: 200,),
                  )
                  :Text("")
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

      );
  }
}
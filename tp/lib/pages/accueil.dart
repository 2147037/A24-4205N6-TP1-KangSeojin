import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../generated/l10n.dart';
import '../models/transfer.dart';
import '../services/lib_http.dart';
import '../widgets/tiroir_nav.dart';
import 'consultation.dart';
import 'creation.dart';

// TODO Un ecran minimal avec un tres peu de code
class Accueil extends StatefulWidget  {
  const Accueil({
    super.key,
    required this.prefs
  });

  final SharedPreferences prefs;

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> with WidgetsBindingObserver {
  List<HomeItemResponse> items = [];
  static int nbListener = 0;
  bool finished =false;

  final stopwatch = Stopwatch();



  @override
  void initState() {
    // TODO: implement initStat
    addListener();
    remplirListe();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // TODO 2 On doit retirer l'observer à la destruction du widget
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }



  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO 3 Les changements d'état de l'application sont gérés ici
    if (state == AppLifecycleState.resumed) {
      remplirListe();
    }
  }



  void remplirListe(){
    finished =false;
    setState(() {});
    try {
      home().then((reponse) {
        print(reponse);
        items = reponse;
        finished = true;
        setState(() {});
      },).catchError((e){
        print(e);
        //throw(e);
        final snackBar = SnackBar(
            content:  Text(S.of(context).tuNesToujoursPasConnect)
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    } catch(e){
      print(e);
      //throw(e);
      final snackBar = SnackBar(
          content:  Text(S.of(context).tuNesToujoursPasConnect)
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }

  }

  void addListener() {
    bool isConnected = true;

    if(nbListener!=0){
      return;
    }
    final listener = InternetConnection().onStatusChange.listen((InternetStatus status){
      print(status);
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

    nbListener++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LeTiroir(username:  SignletonDio.username, prefs: widget.prefs,),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:  Text(S.of(context).accueil, style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(onPressed: remplirListe, icon: Icon(Icons.refresh) ),
        )],


      ),
      body: OrientationBuilder(
          builder: (context,orientation){
            if(orientation == Orientation.portrait){
              nbListener++;
              return finished? _builderPortraitContainers(items: items, finished: finished,  prefs: widget.prefs) : _loading(finished: finished);
            }
            else{
              return finished? _builderPortraitContainers(items: items, finished: finished,  prefs: widget.prefs ) : _loading(finished: finished);
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Creation(prefs: widget.prefs,
                  )
              )
          );
        },
        child: const Icon(Icons.add),
      ),
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
      child: Container(
        height: 300,
        child: LoadingIndicator(
          colors: const [Colors.blue],
          indicatorType: Indicator.circleStrokeSpin ,
          strokeWidth: 3,
          pause: finished,
        ),
      ),
    );
  }
}



class _builderPortraitContainers extends StatelessWidget {
  const _builderPortraitContainers({
    super.key,
    required this.items,
    required this.finished,
    required this.prefs
  });

  final List<HomeItemResponse> items;
  final bool finished ;
  final SharedPreferences prefs;

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
                  Container(
                    width: 200,
                    height: 200,
                    child:  CachedNetworkImage(
                      imageUrl: "http://10.0.2.2:8080/file/" + item.photoId.toString()+"?width=200",
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),),
                  )
                  :Text("")
                ],
              ),
              trailing: IconButton(onPressed: () async{
                try {


                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Consultation(
                              TaskId: item.id,
                              prefs: prefs
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
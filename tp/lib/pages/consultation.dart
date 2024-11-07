import 'dart:ffi';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../generated/l10n.dart';
import '../models/transfer.dart';
import '../services/lib_http.dart';
import '../widgets/tiroir_nav.dart';
import 'accueil.dart';

// TODO Un ecran minimal avec un tres peu de code
class Consultation extends StatefulWidget {
  const Consultation({super.key, required this.TaskId, required this.prefs});

  final int TaskId;
  final SharedPreferences prefs;

  @override
  State<Consultation> createState() => _ConsultationState();
}

class _ConsultationState extends State<Consultation> with WidgetsBindingObserver{
  final progressController = TextEditingController();
  String imagePath = "";
  XFile? pickedImage;
  String imageURL = "";
  Cookie? cookie;
  TaskDetailResponse? item;


  @override
  void initState() {
    remplir();

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
      remplir();
    }
  }

  void remplir() async{
    try {
      item = await detail(widget.TaskId);
      if (item!.photoId != 0) {
        imageURL = "http://10.0.2.2:8080/file/" + item!.photoId.toString()+"?width=200";
      }
      setState(() {

      });
    } catch (e) {
      print(e);
    }
  }

  void deleteTask() async {
    try {
      var reponse = await delete(item!.id);
      print(reponse);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Accueil(prefs: widget.prefs,)));
    } catch (e) {
      print(e);
      throw (e);
    }

  }

  void sendImage() async {
    ImagePicker picker = ImagePicker();
    pickedImage = await picker.pickImage(source: ImageSource.gallery);

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(pickedImage!.path,
          filename: pickedImage!.name),
      "taskID": item!.id
    });

    String id = await up(formData);

    imageURL = "http://10.0.2.2:8080/file/" + id;
    cookie = SignletonDio.cookie;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if(item == null) {
      return Scaffold(
          drawer: LeTiroir(username: SignletonDio.username, prefs: widget.prefs,),
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              S.of(context).consultation,
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          body: Column(
            children: [
              Expanded(
                child: Center(
                    child: CircularProgressIndicator(),

                ),
              ),

            ],
          ),
      );
    }

    progressController.text = item!.percentageDone.toString();
    return Scaffold(
        drawer: LeTiroir(username: SignletonDio.username, prefs: widget.prefs,),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            S.of(context).consultation,
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          actions: [Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: deleteTask, icon: Icon(Icons.delete) ),
          )],
        ),
        body: OrientationBuilder(builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return _buildPortraitContainers(context);
          } else {
            return _buildPortraitContainers(context);
          }
        }));
  }

  Container _buildPortraitContainers(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
            child: Text(
              S.of(context).details,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextField(
              readOnly: true,
              controller: TextEditingController(text: item!.name),
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: S.of(context).nom),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextField(
              readOnly: true,
              controller:
                  TextEditingController(text: item!.deadline.toString()),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: S.of(context).deadline),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextField(
              // controller: TextEditingController(text: widget.tdr.percentageDone.toString() + "%"),
              controller: progressController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: item!.percentageDone.toString() + "%",
                  labelText: S.of(context).percentageDone),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Text(
              "Photo",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Container(
                  height: 250,
                  color: Colors.grey,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        (imageURL == "")
                            ? Text(S.of(context).ajouteUneImage)
                            : Container(
                          width: 200,
                          height: 200,
                          child:  CachedNetworkImage(
                            imageUrl: imageURL,
                            placeholder: (context, url) => CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Icon(Icons.error),),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: OutlinedButton(
              onPressed: sendImage,
              child: Text(S.of(context).envoyerImage),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Text(
              S.of(context).percentageTimeSpent,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: LinearPercentIndicator(
                animation: true,
                animationDuration: 1000,
                lineHeight: 20.0,
                percent: item!.percentageTimeSpent / 100,
                center: Text(item!.percentageTimeSpent.toString() + "%",
                    style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
            child: OutlinedButton(
              onPressed: () async {
                try {
                  var reponse = await updateProgress(
                      item!.id, int.parse(progressController.text));
                  print(reponse);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Accueil(prefs: widget.prefs,)));
                } catch (e) {
                  print(e);
                  throw (e);
                }
              },
              child: Text(S.of(context).modifier),
            ),
          ),
        ],
      ),
    );
  }



}

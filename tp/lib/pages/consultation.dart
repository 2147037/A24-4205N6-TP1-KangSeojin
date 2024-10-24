import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:image_picker/image_picker.dart';
import '../generated/l10n.dart';
import '../models/transfer.dart';
import '../services/lib_http.dart';
import '../widgets/tiroir_nav.dart';
import 'accueil.dart';

// TODO Un ecran minimal avec un tres peu de code
class Consultation extends StatefulWidget {
  const Consultation({super.key, required this.tdr});

  final TaskDetailResponse tdr;

  @override
  State<Consultation> createState() => _ConsultationState();
}

class _ConsultationState extends State<Consultation> {
  final progressController = TextEditingController();
  String imagePath = "";
  XFile? pickedImage;
  String imageURL = "";
  Cookie? cookie;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.tdr.photoId != 0) {
      imageURL = "http://10.0.2.2:8080/file/" + widget.tdr.photoId.toString();
    }
    super.initState();
  }

  /*void getImage() async {
    ImagePicker picker = ImagePicker();
    pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }*/

  void sendImage() async {
    ImagePicker picker = ImagePicker();
    pickedImage = await picker.pickImage(source: ImageSource.gallery);

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(pickedImage!.path,
          filename: pickedImage!.name),
      "taskID": widget.tdr.id
    });

    String id = await up(formData);

    imageURL = "http://10.0.2.2:8080/file/" + id;
    cookie = SignletonDio.cookie;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    progressController.text = widget.tdr.percentageDone.toString();
    return Scaffold(
        drawer: LeTiroir(username: SignletonDio.username),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            S.of(context).consultation,
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
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
              controller: TextEditingController(text: widget.tdr.name),
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: S.of(context).nom),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextField(
              readOnly: true,
              controller:
                  TextEditingController(text: widget.tdr.deadline.toString()),
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
                  hintText: widget.tdr.percentageDone.toString() + "%",
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
                            ? Text("Ajoute une image !!!")
                            : Image.network(
                                imageURL,
                                width: 200,
                                height: 200,
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
              child: Text("Envoyer Image"),
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
                percent: widget.tdr.percentageTimeSpent / 100,
                center: Text(widget.tdr.percentageTimeSpent.toString() + "%",
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
                      widget.tdr.id, int.parse(progressController.text));
                  print(reponse);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Accueil()));
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

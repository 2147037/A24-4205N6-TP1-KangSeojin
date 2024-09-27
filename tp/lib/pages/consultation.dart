import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../generated/l10n.dart';
import '../models/transfer.dart';
import '../services/lib_http.dart';
import '../widgets/tiroir_nav.dart';
import 'accueil.dart';

// TODO Un ecran minimal avec un tres peu de code
class Consultation extends StatefulWidget {
  const Consultation({super.key,  required this.tdr});

  final TaskDetailResponse tdr;

  @override
  State<Consultation> createState() => _ConsultationState();
}

class _ConsultationState extends State<Consultation> {
  final progressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    progressController.text = widget.tdr.percentageDone.toString();
    return Scaffold(
      drawer: LeTiroir(username:  SignletonDio.username),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:  Text(S.of(context).consultation, style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(

        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0,150,0,40),
              child: Text(S.of(context).details, style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20,10,20,10),
              child: TextField(
                readOnly: true,
                controller: TextEditingController(text: widget.tdr.name),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: S.of(context).nom
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20,10,20,10),
              child: TextField(
                readOnly: true,
                controller: TextEditingController(text: widget.tdr.deadline.toString()),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: S.of(context).deadline
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20,10,20,10),
              child: TextField(
                // controller: TextEditingController(text: widget.tdr.percentageDone.toString() + "%"),
                controller: progressController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: widget.tdr.percentageDone.toString() + "%",
                    labelText: S.of(context).percentageDone
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20,10,20,0),
              child: Text(
                S.of(context).percentageTimeSpent,
                style:TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(10,10,10,10),
                child: LinearPercentIndicator(
                  animation: true,
                  animationDuration: 1000,
                  lineHeight: 20.0,
                  percent: widget.tdr.percentageTimeSpent/100,
                  center: Text(
                      widget.tdr.percentageTimeSpent.toString() + "%",
                      style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      )
                  ),

                )
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40,10,40,10),
              child: OutlinedButton(
                onPressed: () async{
                  try {

                    var reponse = await updateProgress(widget.tdr.id, int.parse(progressController.text));
                    print(reponse);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Accueil(
                            )
                        )
                    );
                  } catch(e){
                    print(e);
                    throw(e);
                  }

                },
                child: Text(S.of(context).modifier),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
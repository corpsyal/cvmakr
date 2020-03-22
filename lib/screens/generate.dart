import 'dart:convert';
import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:cvmakr/components/custom-button.dart';
import 'package:cvmakr/consts.dart';
import 'package:cvmakr/data/data.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

String url = 'http://192.168.1.13:3000/template';

class Generate extends StatefulWidget {
  @override
  _GenerateState createState() => _GenerateState();
}

class _GenerateState extends State<Generate> {
  final Trace myTrace = FirebasePerformance.instance.newTrace("generate_trace");

  final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
    functionName: 'generatePdf',
  );

  Future<String> generateCV(Data data) async {
    myTrace.start();
    Map<String, String> bodyRequest = {'data': jsonEncode(data.toJson())};
    String result;
    if (data.avatar != null) {
      File avatar = File(data.avatar);
      String extension = p.extension(avatar.path);

      String uniqId = Uuid().v1();

      String avatarId = "$uniqId$extension";
      print('uniqueKey $avatarId');

      await Data.storage
          .ref()
          .child('avatars')
          .child(avatarId)
          .putFile(avatar)
          .onComplete;

      //File file = File(data.avatar);
      bodyRequest['avatar'] = avatarId;
    }
    print(bodyRequest);
    try {
      HttpsCallableResult resp = await callable.call(bodyRequest);
      print(resp.data);
      result = resp.data;
      myTrace.incrementMetric("generate_successful", 1);

/*
      http.Response resp = await http.post(
          'http://192.168.1.13:5000/cvmakr-19bc1/us-central1/generatePdf',
          body: bodyRequest);
      print(resp.body);
      return resp.body;
       */

    } catch (e) {
      print(e);
      myTrace.incrementMetric("generate_fail", 1);
    }

    myTrace.stop();
    return result;

/*
    http.Response response = await http.post(url, body: bodyRequest);
    String id = response.body;
    return id;
    */
  }

  @override
  Widget build(BuildContext context) {
    Data data = Provider.of<Data>(context);

    return Material(
      child: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 30),
                color: primaryColor,
                child: Image.asset('images/work-in-progress.png'),
              ),
              Expanded(
                child: Container(
                  //color: Colors.red,
                  child: Center(
                    child: FutureBuilder(
                        future: generateCV(data),
                        builder: (context, AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            print(snapshot);
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Center(
                                child: RaisedButton(
                                  onPressed: () {
                                    launch(snapshot.data);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.archive,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text('Télécharger',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                  ),
                                  elevation: 0,
                                  color: primaryColor,
                                  padding: EdgeInsets.symmetric(vertical: 25.0),
                                ),
                              ),
                            );
                          } else {
                            return SpinKitThreeBounce(
                              color: primaryColor,
                              size: 25.0,
                            );
                          }
                        }),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: CustomButton(
                  label: "Je retourne à l'accueil",
                  width: double.infinity,
                  isSecondary: true,
                  onPress: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

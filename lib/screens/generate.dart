import 'dart:convert';
import 'dart:io';

import 'package:cvmakr/components/custom-button.dart';
import 'package:cvmakr/consts.dart';
import 'package:cvmakr/data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

String url = 'http://192.168.1.13:3000/template';

class Generate extends StatelessWidget {
  Future<String> generateCV(data) async {
    Map<String, String> bodyRequest = {'data': jsonEncode(data.toJson())};
    print(data.avatar);
    if (data.avatar != null) {
      File file = File(data.avatar);
      bodyRequest['avatar'] = base64Encode(file.readAsBytesSync());
    }

    http.Response response = await http.post(url, body: bodyRequest);
    String id = response.body;
    return id;
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
                            String id = snapshot.data;
                            String link = '$url/$id';
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Center(
                                child: RaisedButton(
                                  onPressed: () {
                                    launch(link);
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

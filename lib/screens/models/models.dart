import 'dart:convert';

import 'package:cvmakr/components/form-container.dart';
import 'package:cvmakr/consts.dart';
import 'package:cvmakr/screens/models/item_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

Future<http.Response> fetchAlbum() {
  return http.get('http://192.168.1.13:3000/templates');
}

class Models extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FormContainer(
      title: 'Modèles de CV',
      child: FutureBuilder(
          future: fetchAlbum(),
          builder: (context, AsyncSnapshot<http.Response> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                print(snapshot.error.toString());
                return Text('Une erreur est survenue...');
              }
              print(snapshot.data.body);
              List<String> allIds =
                  List<String>.from(jsonDecode(snapshot.data.body));

              return GridView.count(
                //crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                crossAxisCount: 1,
                children: allIds
                    .map((id) => ItemModels(
                          id: id,
                        ))
                    .toList(),
              );
            } else
              return SpinKitThreeBounce(
                color: primaryColor,
                size: 25.0,
              );
          }),
    );
  }
}

import 'dart:convert';

import 'package:cvmakr/components/form-container.dart';
import 'package:cvmakr/consts.dart';
import 'package:cvmakr/data/data.dart';
import 'package:cvmakr/screens/models/item_models.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

/*
await Data.storage
      .ref()
      .child('templates/01/preview.png')
      .getDownloadURL();
 */

List<String> getIds(data) {
  RemoteConfigValue availaibleTemplatesIds =
      data.remoteConfig.getValue('available_templates_ids');
  List<String> ids =
      List<String>.from(jsonDecode(availaibleTemplatesIds.asString()));
  return ids;
}

Future<List<Map<String, String>>> getLinks(Data data) async {
  List<String> ids = getIds(data);
  List<Map<String, String>> links = await Future.wait(ids.map((id) async {
    String link = await Data.storage
        .ref()
        .child('templates/$id/preview.png')
        .getDownloadURL();
    return {'id': id, 'link': link};
  }));

  return links;
}

class Models extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Data data = Provider.of<Data>(context);

    return FormContainer(
      title: 'Modèles de CV',
      child: FutureBuilder(
          future: getLinks(data),
          builder:
              (context, AsyncSnapshot<List<Map<String, String>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                print(snapshot.error.toString());
                return Text('Une erreur est survenue...');
              }
              // print(snapshot.data);

              return GridView.count(
                //crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                crossAxisCount: 1,
                children: snapshot.data
                    .map((template) =>
                        ItemModels(link: template['link'], id: template['id']))
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

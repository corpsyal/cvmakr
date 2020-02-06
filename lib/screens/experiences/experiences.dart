import 'dart:convert';

import 'package:cvmakr/components/form-container.dart';
import 'package:cvmakr/data/data.dart';
import 'package:cvmakr/screens/experiences/empty_experiences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Experiences extends StatelessWidget {
  static const String id = 'experiences';

  @override
  Widget build(BuildContext context) {
    Data data = Provider.of<Data>(context);
    //print(data.experiences);
    return FormContainer(
        title: "Expériences",
        child: data.experiences.length > 0
            ? RaisedButton(
                onPressed: () {
                  data.experiences.removeAt(0);
                  print(data.experiences);
                  data.save();
                  /*

                  print(data.toJson());
                  print(jsonDecode(data.toJson()));
                   */
                },
              )
            : EmptyExperiences());
  }
}

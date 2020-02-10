import 'package:cvmakr/components/add-floatting-button.dart';
import 'package:cvmakr/data/data.dart';
import 'package:cvmakr/data/experience.dart';
import 'package:cvmakr/screens/experiences/add_experiences.dart';
import 'package:cvmakr/screens/experiences/item_experiences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListExperiences extends StatelessWidget {
  static const String id = 'list_experiences';

  @override
  Widget build(BuildContext context) {
    Data data = Provider.of<Data>(context);
    //print(data.experiences);
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 1),
            itemCount: data.experiences.length,
            itemBuilder: (context, index) {
              Experience experience = data.experiences[index];
              return ItemExperiences(experience: experience);
            }),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(top: 10),
          child: AddFloatingButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddExperiences()),
            ),
          ),
        ));
  }
}
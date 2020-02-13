import 'package:cvmakr/screens/emptyScreen.dart';
import 'package:cvmakr/screens/experiences/add_experiences.dart';
import 'package:flutter/material.dart';

class EmptyExperiences extends StatelessWidget {
  static const String id = 'empty_experiences';

  @override
  Widget build(BuildContext context) {
    return EmptyScreen(
      mainLabel: "Pas encore d'experiences !",
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddExperiences()),
      ),
    );
  }
}

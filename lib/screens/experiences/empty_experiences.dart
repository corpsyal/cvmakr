import 'package:cvmakr/components/empty-screen.dart';
import 'package:cvmakr/data/data.dart';
import 'package:cvmakr/screens/experiences/add_experiences.dart';
import 'package:flutter/material.dart';

class EmptyExperiences extends StatelessWidget {
  static const String id = 'empty_experiences';

  @override
  Widget build(BuildContext context) {
    return EmptyScreen(
      mainLabel: Data.translate("no_skill_yet"),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddExperiences()),
      ),
    );
  }
}

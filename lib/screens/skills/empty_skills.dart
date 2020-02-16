import 'package:cvmakr/components/empty-screen.dart';
import 'package:cvmakr/data/skill.dart';
import 'package:cvmakr/screens/skills/add_skills.dart';
import 'package:flutter/material.dart';

class EmptySkills extends StatelessWidget {
  static const String id = 'empty_skills';

  @override
  Widget build(BuildContext context) {
    return EmptyScreen(
      mainLabel: "Pas encore de compétences !",
      onPressed: () =>
          settingModalBottomSheet(context, Skill(), mode: skillMode.add),
    );
  }
}

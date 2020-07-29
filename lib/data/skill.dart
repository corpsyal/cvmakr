import 'package:flutter/material.dart';

class Skill extends ChangeNotifier {
  String skill;
  String level;

  Skill({
    this.skill = "",
    this.level = "70",
  });

  Skill.fromMap(Map<String, dynamic> exp)
      : skill = exp["skill"],
        level = exp["level"];

  Map<String, dynamic> toJson() => {
        'skill': skill,
        'level': level,
      };
}

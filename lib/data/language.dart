import 'package:flutter/material.dart';

enum LanguageEnum { beginner, medium, high, expert }

class Language extends ChangeNotifier {
  String language;
  LanguageEnum level;

  Language({
    this.language = "fr",
    this.level = LanguageEnum.medium,
  });

  Language.fromMap(Map<String, dynamic> exp)
      : language = exp["language"],
        level =
            LanguageEnum.values.firstWhere((l) => l.toString() == exp['level']);

  Map<String, dynamic> toJson() => {
        'language': language,
        'level': level.toString(),
      };
}

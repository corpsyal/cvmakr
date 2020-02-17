import 'package:cvmakr/components/empty-screen.dart';
import 'package:cvmakr/data/language.dart';
import 'package:cvmakr/screens/languages/add_languages.dart';
import 'package:flutter/material.dart';

class EmptyLanguages extends StatelessWidget {
  static const String id = 'empty_languages';

  @override
  Widget build(BuildContext context) {
    return EmptyScreen(
      mainLabel: "Pas encore de langues !",
      onPressed: () =>
          settingModalBottomSheet(context, Language(), mode: languageMode.add),
    );
  }
}

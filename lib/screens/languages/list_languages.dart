import 'package:cvmakr/components/add-floatting-button.dart';
import 'package:cvmakr/data/data.dart';
import 'package:cvmakr/data/language.dart';
import 'package:cvmakr/screens/languages/add_languages.dart';
import 'package:cvmakr/screens/languages/item_languages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

class ListLanguages extends StatelessWidget {
  static const String id = 'list_languages';

  @override
  Widget build(BuildContext context) {
    Data data = Provider.of<Data>(context);
    //print(data.experiences);
    return Scaffold(
        backgroundColor: Colors.white,
        body: ReorderableColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: data.languages
              .map((language) => ItemLanguages(
                    language: language,
                    key: ValueKey(language),
                  ))
              .toList(),
          onReorder: (int oldIndex, int newIndex) {
            data.moveLanguage(oldIndex, newIndex);
          },
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(top: 10),
          child: AddFloatingButton(
            onPressed: () => settingModalBottomSheet(context, Language(),
                mode: languageMode.add),
          ),
        ));
  }
}

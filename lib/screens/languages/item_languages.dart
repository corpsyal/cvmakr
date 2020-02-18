import 'package:cvmakr/components/custom-dropdown.dart';
import 'package:cvmakr/components/language-level-selector.dart';
import 'package:cvmakr/components/menu.dart';
import 'package:cvmakr/consts.dart';
import 'package:cvmakr/data/data.dart';
import 'package:cvmakr/data/language.dart';
import 'package:cvmakr/screens/languages/add_languages.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

final dateFormat = new DateFormat('MMMM yyyy');

class ItemLanguages extends StatelessWidget {
  final Language language;
  final Key key;

  ItemLanguages({this.language, this.key});

  @override
  Widget build(BuildContext context) {
    Data data = Provider.of<Data>(context);

    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Image.asset(
              'images/flags/${language.language}.png',
              width: 64,
              height: 64,
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    languages[language.language],
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      getLevelLabel(language.level),
                      style: TextStyle(color: Colors.white),
                    ),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Icon(
                      Icons.drag_handle,
                      color: Colors.grey[400],
                    ),
                  )
                ],
              ),
            ),
            Menu(onSelect: (menu value) {
              if (value == menu.remove) data.removeLanguage(language);
              if (value == menu.edit)
                settingModalBottomSheet(context, language,
                    mode: languageMode.edit);
            })
          ],
        ),
      ),
    );
  }
}

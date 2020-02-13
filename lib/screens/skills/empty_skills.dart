import 'package:cvmakr/screens/emptyScreen.dart';
import 'package:flutter/material.dart';

class EmptySkills extends StatelessWidget {
  static const String id = 'empty_skills';

  @override
  Widget build(BuildContext context) {
    return EmptyScreen(
      mainLabel: "Pas encore de compétences !",
      onPressed: _settingModalBottomSheet(context),
    );
  }
}

Function _settingModalBottomSheet(context) => () => showModalBottomSheet(
      //isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      context: context,
      builder: (BuildContext bc) => Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: <Widget>[
            Text('Ajouter une compétence'),
            TextField(),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
      ),
    );

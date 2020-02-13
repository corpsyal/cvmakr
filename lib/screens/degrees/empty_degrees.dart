import 'package:cvmakr/components/add-floatting-button.dart';
import 'package:cvmakr/consts.dart';
import 'package:cvmakr/screens/degrees/add_degrees.dart';
import 'package:flutter/material.dart';

class EmptyDegrees extends StatelessWidget {
  static const String id = 'empty_degrees';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Image.asset("images/empty.png"),
        Text(
          "Pas encore de formations !",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        Column(
          children: <Widget>[
            Text("Vous pouvez en ajouter une en cliquant",
                style: secondaryTextStyle),
            Text(
              "sur le bouton + juste en dessous",
              style: secondaryTextStyle,
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        AddFloatingButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDegrees()),
          ),
        )
      ],
    );
  }
}

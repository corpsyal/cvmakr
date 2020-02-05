import 'package:flutter/material.dart';
import 'package:cvmakr/consts.dart';

class EmptyExperiences extends StatelessWidget {
  static const String id = 'empty_experiences';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Image.asset("images/empty.png"),
        Text(
          "Pas encore d'expériences !",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500
          ),
        ),
        Column(
          children: <Widget>[
            Text("Vous pouvez en ajouter une en cliquant",
                style: secondaryTextStyle
            ),
            Text("sur le bouton + juste en dessous", style: secondaryTextStyle,)
          ],
        ),

        SizedBox(height: 20,),
        FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: primaryColor,
          elevation: 0,
        )
      ],
    );
  }
}

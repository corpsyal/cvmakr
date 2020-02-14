import 'package:cvmakr/components/add-floatting-button.dart';
import 'package:cvmakr/consts.dart';
import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  static const String id = 'empty_skills';
  final Function onPressed;
  final String mainLabel;

  EmptyScreen({this.onPressed, this.mainLabel});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) => Scaffold(
              body: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Image.asset(
                          "images/empty.png",
                        ),
                        Text(
                          mainLabel,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
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
                          height: 60,
                        ),
                        AddFloatingButton(
                          onPressed: onPressed,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}

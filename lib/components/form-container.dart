import 'dart:async';

import 'package:cvmakr/consts.dart';
import 'package:cvmakr/data/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

TextStyle textStyle = TextStyle(color: primaryColor, fontSize: 15);

Future<bool> onBack(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        Data data = Provider.of<Data>(context);
        print(data.hasUnsavedChange());
        return AlertDialog(
          // title: Text('Modifications non sauvegardées'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Continuer sans sauvegarder ?",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () =>
                        Navigator.of(context).pop(false), // valeure de return
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Non",
                        style: textStyle,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      data.resetUnsavedChange();
                      Navigator.of(context).pop(true); // valeur de return
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text("Oui", style: textStyle),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      });
  // : Navigator.of(context).pop(true);
}

Future<bool> noChange(BuildContext context) async {
  return true;
}

typedef Future<dynamic> onWillPopFunc();

class FormContainer extends StatelessWidget {
  String title;
  Widget child;
  Function onWillPop;
  double padding;

  FormContainer({this.title, this.child, this.onWillPop, this.padding = 20});

  @override
  Widget build(BuildContext context) {
    Data data = Provider.of<Data>(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.3, 0.3],
        ),
      ),
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  color: primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    padding: EdgeInsets.only(left: 20),
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () async {
                        if (onWillPop != null) {
                          bool continueWithoutSave = await onWillPop();
                          if (continueWithoutSave) Navigator.of(context).pop();
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            title,
                            //textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: padding != null ? EdgeInsets.all(padding) : null,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

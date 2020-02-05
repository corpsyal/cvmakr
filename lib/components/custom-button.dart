import 'package:flutter/material.dart';
import 'package:cvmakr/consts.dart';

class CustomButton extends StatelessWidget {
  String label;
  Function onPress;

  CustomButton({this.label, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        //splashColor: Colors.white,
        //highlightColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(8.0),
        ),
        elevation: 0,
        color: primaryColor,
        padding: EdgeInsets.symmetric(vertical: 25.0),
        child: Text(
          label,
          style:
          TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: onPress,
      ),
    );
  }
}

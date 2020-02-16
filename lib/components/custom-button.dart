import 'package:cvmakr/consts.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Function onPress;
  final double width;
  final bool isSecondary;

  CustomButton(
      {this.label, this.onPress, this.width, this.isSecondary = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: RaisedButton(
        //splashColor: Colors.white,
        //highlightColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(8.0),
        ),
        elevation: 0,
        color: isSecondary ? Colors.white : primaryColor,
        padding: EdgeInsets.symmetric(vertical: 25.0),
        child: Text(
          label,
          style: TextStyle(
              color: isSecondary ? primaryColor : Colors.white,
              fontWeight: isSecondary ? FontWeight.w500 : FontWeight.bold),
        ),
        onPressed: onPress,
      ),
    );
  }
}

import 'package:cvmakr/consts.dart';
import 'package:flutter/material.dart';

class AddFloatingButton extends StatelessWidget {
  Function onPressed;

  AddFloatingButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: primaryColor,
      elevation: 0,
      onPressed: onPressed,
    );
  }
}

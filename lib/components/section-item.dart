import 'package:flutter/material.dart';
import 'package:cvmakr/consts.dart';
import 'package:flutter/cupertino.dart';

class SectionItem extends StatelessWidget {
  String title;
  IconData iconName;
  String route;
  Function onTap;

  SectionItem({this.title, this.iconName, this.route, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        //color: Colors.red,
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  iconName,
                  color: primaryColor,
                  size: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Icon(Icons.chevron_right, size: 40)
          ],
        ),
      ),
    );
  }
}

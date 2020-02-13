import 'package:cvmakr/components/menu.dart';
import 'package:cvmakr/consts.dart';
import 'package:cvmakr/data/data.dart';
import 'package:cvmakr/data/degree.dart';
import 'package:cvmakr/screens/degrees/add_degrees.dart';
import 'package:cvmakr/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

final dateFormat = new DateFormat('MMMM yyyy');

class ItemDegrees extends StatelessWidget {
  final Degree degree;
  final Key key;

  ItemDegrees({this.degree, this.key});

  @override
  Widget build(BuildContext context) {
    Data data = Provider.of<Data>(context);

    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Chip(
                    label: Text(
                      capitalize(degree.degree),
                      overflow: TextOverflow.ellipsis,
                    ),
                    backgroundColor: primaryColor,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
                Menu(onSelect: (menu value) {
                  if (value == menu.remove) data.removeDegree(degree);
                  if (value == menu.edit)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddDegrees(
                                degree: degree,
                              )),
                    );
                })
              ],
            ),

            SizedBox(
              height: 10,
            ),
            Text(
              capitalize(degree.school),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
                '${capitalize(dateFormat.format(degree.from))} - ${capitalize(dateFormat.format(degree.to))}'), //degree.from
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text(degree.description),
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
    );
  }
}

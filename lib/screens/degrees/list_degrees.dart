import 'package:cvmakr/components/add-floatting-button.dart';
import 'package:cvmakr/data/data.dart';
import 'package:cvmakr/screens/degrees/add_degrees.dart';
import 'package:cvmakr/screens/degrees/item_degrees.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

class SingleWrap extends StatelessWidget {
  final Widget child;
  final Key key;

  SingleWrap({this.child, this.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: new BoxConstraints(
        minHeight: 5.0,
        minWidth: 5.0,
      ),
      child: new DecoratedBox(
        decoration: new BoxDecoration(color: Colors.red),
        child: child,
      ),
    );
  }
}

class ListDegrees extends StatelessWidget {
  static const String id = 'list_degrees';

  @override
  Widget build(BuildContext context) {
    Data data = Provider.of<Data>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        body: ReorderableColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: data.degrees
              .map((degree) => ItemDegrees(
                    degree: degree,
                    key: ValueKey(degree),
                  ))
              .toList(),
          onReorder: (int oldIndex, int newIndex) {
            data.moveDegree(oldIndex, newIndex);
          },
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(top: 10),
          child: AddFloatingButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddDegrees()),
            ),
          ),
        ));
  }
}

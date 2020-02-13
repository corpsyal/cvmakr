import 'package:cvmakr/components/add-floatting-button.dart';
import 'package:cvmakr/data/data.dart';
import 'package:cvmakr/screens/experiences/add_experiences.dart';
import 'package:cvmakr/screens/experiences/item_experiences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

class SingleWrap extends StatelessWidget {
  Widget child;
  Key key;
  SingleWrap({this.child, this.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: new BoxConstraints(
        minHeight: 5.0,
        minWidth: 5.0,
        //maxHeight: double.infinity,
        //maxWidth: double.infinity,
      ),
      child: new DecoratedBox(
        decoration: new BoxDecoration(color: Colors.red),
        child: child,
      ),
    );
  }
}

class ListExperiences extends StatelessWidget {
  static const String id = 'list_experiences';

  @override
  Widget build(BuildContext context) {
    Data data = Provider.of<Data>(context);
    //print(data.experiences);
    return Scaffold(
        backgroundColor: Colors.white,
        body: ReorderableColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: data.experiences
              .map((experience) => ItemExperiences(
                    experience: experience,
                    key: ValueKey(experience),
                  ))
              .toList(),
          onReorder: (int oldIndex, int newIndex) {
            data.moveExperience(oldIndex, newIndex);
          },
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(top: 10),
          child: AddFloatingButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddExperiences()),
            ),
          ),
        ));
  }
}

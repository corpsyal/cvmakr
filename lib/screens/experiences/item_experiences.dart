import 'package:cvmakr/components/menu.dart';
import 'package:cvmakr/consts.dart';
import 'package:cvmakr/data/data.dart';
import 'package:cvmakr/data/experience.dart';
import 'package:cvmakr/screens/experiences/add_experiences.dart';
import 'package:cvmakr/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemExperiences extends StatelessWidget {
  final Experience experience;
  final Key key;

  ItemExperiences({this.experience, this.key});

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
                      capitalize(experience.job),
                      overflow: TextOverflow.ellipsis,
                    ),
                    backgroundColor: primaryColor,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
                Menu(onSelect: (menu value) {
                  if (value == menu.remove) data.removeExperience(experience);
                  if (value == menu.edit)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddExperiences(
                                experience: experience,
                              )),
                    );
                })
              ],
            ),

            SizedBox(
              height: 10,
            ),
            Text(
              capitalize(experience.company),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(renderDate(experience.from, experience.to)), //experience.from
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text(experience.description),
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

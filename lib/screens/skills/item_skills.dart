import 'package:cvmakr/components/custom-slider.dart';
import 'package:cvmakr/components/menu.dart';
import 'package:cvmakr/data/data.dart';
import 'package:cvmakr/data/skill.dart';
import 'package:cvmakr/screens/skills/add_skills.dart';
import 'package:cvmakr/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

final dateFormat = new DateFormat('MMMM yyyy');

class ItemSkills extends StatelessWidget {
  final Skill skill;
  final Key key;

  ItemSkills({this.skill, this.key});

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
                Expanded(
                  child: Text(
                    capitalize(
                      skill.skill,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Menu(onSelect: (menu value) {
                  if (value == menu.remove) data.removeSkill(skill);
                  if (value == menu.edit)
                    settingModalBottomSheet(context, skill,
                        mode: skillMode.edit);
                })
              ],
            ),
            CustomSlider(
              value: skill.level,
              onChanged: (value) {},
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

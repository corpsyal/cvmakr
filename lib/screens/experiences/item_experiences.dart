import 'package:cvmakr/components/menu.dart';
import 'package:cvmakr/consts.dart';
import 'package:cvmakr/data/data.dart';
import 'package:cvmakr/data/experience.dart';
import 'package:cvmakr/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

final dateFormat = new DateFormat('MMMM yyyy');

class ItemExperiences extends StatelessWidget {
  final Experience experience;

  ItemExperiences({this.experience});

  @override
  Widget build(BuildContext context) {
    Data data = Provider.of<Data>(context);
    print(experience);
    return Card(
      margin: EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          trailing: Menu(onSelect: (menu value) {
            if (value == menu.remove) data.removeExperience(experience);
          }),
          title: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Text(
                capitalize(experience.job),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          subtitle: Container(
            margin: EdgeInsets.only(top: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    experience.company,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      '${capitalize(dateFormat.format(experience.from))} - ${capitalize(dateFormat.format(experience.to))}'), //experience.from
                  SizedBox(
                    height: 10,
                  ),
                  Text(experience.description)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cvmakr/components/custom-button.dart';
import 'package:cvmakr/components/custom-datetime-input.dart';
import 'package:cvmakr/components/custom-input.dart';
import 'package:cvmakr/components/form-container.dart';
import 'package:cvmakr/data/data.dart';
import 'package:cvmakr/data/degree.dart';
import 'package:cvmakr/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

enum mode { add, edit }
String getButtonLabel(mode m) {
  String label;
  switch (m) {
    case mode.add:
      label = "Ajouter";
      break;
    case mode.edit:
      label = 'Modifier';
      break;
  }
  return label;
}

class AddDegrees extends StatefulWidget {
  static const String id = 'add_degrees';

  final Degree degree;
  final mode degreeMode;

  AddDegrees({Degree degree})
      : this.degree = degree ?? Degree(),
        this.degreeMode = degree != null ? mode.edit : mode.add;

  @override
  _AddDegreesState createState() => _AddDegreesState();
}

class _AddDegreesState extends State<AddDegrees> {
  final dateFormat = new DateFormat('MM/yyyy');

  @override
  Widget build(BuildContext context) {
    Data data = Provider.of<Data>(context);
    print(widget.degree.from);
    return FormContainer(
      title: "Ajouter une expérience",
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CustomInput(
              label: "Formation",
              initialValue: widget.degree.degree,
              onChange: (String degree) {
                widget.degree.degree = degree;
              },
            ),
            CustomInput(
              label: "Ecole",
              initialValue: widget.degree.school,
              onChange: (String school) {
                widget.degree.school = school;
              },
            ),
            Row(
              children: <Widget>[
                CustomDateTimeInput(
                    label: "De",
                    initialValue:
                        capitalize(dateFormat.format(widget.degree.from)),
                    onConfirm: (dateTime, _) {
                      setState(() {
                        widget.degree.from = dateTime;
                      });
                    }),
                SizedBox(
                  width: 20,
                ),
                CustomDateTimeInput(
                    label: "Jusque",
                    initialValue:
                        capitalize(dateFormat.format(widget.degree.to)),
                    onConfirm: (dateTime, _) {
                      setState(() {
                        widget.degree.to = dateTime;
                      });
                    }),
              ],
            ),
            CustomInput(
              label: "Courte description",
              maxLines: 6,
              initialValue: widget.degree.description,
              onChange: (String description) {
                widget.degree.description = description;
              },
            ),
            CustomButton(
              label: getButtonLabel(widget.degreeMode),
              onPress: () async {
                print(widget.degree.toJson());
                if (widget.degreeMode == mode.add)
                  data.addDegree(widget.degree);
                await data.save();
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

import 'package:cvmakr/components/custom-button.dart';
import 'package:cvmakr/components/custom-datetime-input.dart';
import 'package:cvmakr/components/custom-input.dart';
import 'package:cvmakr/components/form-container.dart';
import 'package:cvmakr/data/data.dart';
import 'package:cvmakr/data/experience.dart';
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

class AddExperiences extends StatefulWidget {
  static const String id = 'add_experiences';

  final Experience experience;
  final mode experienceMode;

  AddExperiences({Experience experience})
      : this.experience = experience ?? Experience(),
        this.experienceMode = experience != null ? mode.edit : mode.add;

  @override
  _AddExperiencesState createState() => _AddExperiencesState();
}

class _AddExperiencesState extends State<AddExperiences> {
  final dateFormat = new DateFormat('MM/yyyy');

  @override
  Widget build(BuildContext context) {
    Data data = Provider.of<Data>(context);
    print(widget.experience.from);
    return FormContainer(
      title: "Ajouter une expérience",
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CustomInput(
              label: "Poste",
              initialValue: widget.experience.job,
              onChange: (String job) {
                widget.experience.job = job;
              },
            ),
            CustomInput(
              label: "Entreprise",
              initialValue: widget.experience.company,
              onChange: (String company) {
                widget.experience.company = company;
              },
            ),
            Row(
              children: <Widget>[
                CustomDateTimeInput(
                    label: "De",
                    initialValue:
                        capitalize(dateFormat.format(widget.experience.from)),
                    onConfirm: (dateTime, _) {
                      setState(() {
                        widget.experience.from = dateTime;
                      });
                    }),
                SizedBox(
                  width: 20,
                ),
                CustomDateTimeInput(
                    label: "Jusque",
                    initialValue:
                        capitalize(dateFormat.format(widget.experience.to)),
                    onConfirm: (dateTime, _) {
                      setState(() {
                        widget.experience.to = dateTime;
                      });
                    }),
              ],
            ),
            CustomInput(
              label: "Courte description",
              maxLines: 6,
              initialValue: widget.experience.description,
              onChange: (String description) {
                widget.experience.description = description;
              },
            ),
            CustomButton(
              width: double.infinity,
              label: getButtonLabel(widget.experienceMode),
              onPress: () async {
                print(widget.experience.toJson());
                if (widget.experienceMode == mode.add)
                  data.addExperience(widget.experience);
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

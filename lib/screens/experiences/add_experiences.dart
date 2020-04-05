import 'package:cvmakr/components/custom-button.dart';
import 'package:cvmakr/components/custom-datetime-input.dart';
import 'package:cvmakr/components/custom-input.dart';
import 'package:cvmakr/components/form-container.dart';
import 'package:cvmakr/consts.dart';
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
      label = "add";
      break;
    case mode.edit:
      label = 'update';
      break;
  }
  return Data.translate(label);
}

class AddExperiences extends StatefulWidget {
  static const String id = 'add_experiences';

  final Experience experience;
  final Experience initialExperience;
  final mode experienceMode;

  AddExperiences({Experience experience})
      : this.experience = experience ?? Experience(),
        this.initialExperience =
            Experience.fromMap((experience ?? Experience()).toJson()),
        this.experienceMode = experience != null ? mode.edit : mode.add;

  @override
  _AddExperiencesState createState() => _AddExperiencesState();
}

class _AddExperiencesState extends State<AddExperiences> {
  final dateFormat = new DateFormat('MM/yyyy');

  @override
  Widget build(BuildContext context) {
    Data data = Provider.of<Data>(context);

    return FormContainer(
      onWillPop: () => widget.experience.isEqual(widget.initialExperience)
          ? noChange(context)
          : onBack(context),
      title: Data.translate("add_experience"),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CustomInput(
              label: Data.translate("job"),
              initialValue: widget.experience.job,
              onChange: (String job) {
                widget.experience.job = job;
              },
            ),
            CustomInput(
              label: Data.translate("company"),
              initialValue: widget.experience.company,
              onChange: (String company) {
                widget.experience.company = company;
              },
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        '',
                        style: TextStyle(fontSize: 10),
                      ),
                      CustomDateTimeInput(
                          label: Data.translate("from"),
                          initialValue: widget.experience.from != null
                              ? capitalize(
                                  dateFormat.format(widget.experience.from))
                              : null,
                          onConfirm: (dateTime, _) {
                            setState(() {
                              widget.experience.from = dateTime;
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            });
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                          child: Text(
                        Data.translate("empty_if_now"),
                        style: TextStyle(fontSize: 10, color: secondTextColor),
                      )),
                      CustomDateTimeInput(
                          label: Data.translate("to"),
                          initialValue: widget.experience.to != null
                              ? capitalize(
                                  dateFormat.format(widget.experience.to))
                              : null,
                          onConfirm: (dateTime, _) {
                            setState(() {
                              widget.experience.to = dateTime;
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            });
                          }),
                    ],
                  ),
                ),
              ],
            ),
            CustomInput(
              label: Data.translate("description"),
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

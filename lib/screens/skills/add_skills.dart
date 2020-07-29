import 'package:cvmakr/components/custom-button.dart';
import 'package:cvmakr/components/custom-input.dart';
import 'package:cvmakr/components/custom-slider.dart';
import 'package:cvmakr/data/data.dart';
import 'package:cvmakr/data/skill.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum skillMode { add, edit }
String getButtonLabel(skillMode m) {
  String label;
  switch (m) {
    case skillMode.add:
      label = "add";
      break;
    case skillMode.edit:
      label = 'update';
      break;
  }
  return Data.translate(label);
}

Future settingModalBottomSheet(context, Skill skill, {skillMode mode}) =>
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      context: context,
      builder: (BuildContext bottomSheetContext) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        Data data = Provider.of<Data>(context);

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom == 0
                        ? 0
                        : MediaQuery.of(context).viewInsets.bottom / 2),
                child: CustomInput(
                  initialValue: skill.skill,
                  label: Data.translate("skill"),
                  onChange: (skillValue) {
                    skill.skill = skillValue;
                  },
                ),
              ),
              CustomSlider(
                  value: skill.level,
                  onChanged: (skillLevel) {
                    setState(() {
                      skill.level = skillLevel.round().toString();
                    });
                  }),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: CustomButton(
                      label: Data.translate("close"),
                      isSecondary: true,
                      onPress: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: CustomButton(
                      label: getButtonLabel(mode),
                      onPress: () async {
                        if (mode == skillMode.add) data.addSkill(skill);
                        await data.save();
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        );
      }),
    );

import 'package:cvmakr/consts.dart';
import 'package:cvmakr/data/language.dart';
import 'package:flutter/material.dart';

String getLevelLabel(LanguageEnum level) {
  String label;
  switch (level) {
    case LanguageEnum.beginner:
      label = 'Débutant';
      break;
    case LanguageEnum.medium:
      label = 'Intermédiaire ';
      break;
    case LanguageEnum.high:
      label = 'Maitrise';
      break;
    case LanguageEnum.expert:
      label = 'Bilingue';
      break;
  }
  return label;
}

class LanguageLevelSelector extends StatelessWidget {
  final Function onChange;
  final LanguageEnum value;

  LanguageLevelSelector({this.onChange, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              _LanguageLevelSelectorItem(
                  value: LanguageEnum.beginner,
                  onSelect: onChange,
                  actualValue: value),
              SizedBox(
                width: 15,
              ),
              _LanguageLevelSelectorItem(
                value: LanguageEnum.medium,
                onSelect: onChange,
                actualValue: value,
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              _LanguageLevelSelectorItem(
                value: LanguageEnum.high,
                onSelect: onChange,
                actualValue: value,
              ),
              SizedBox(
                width: 20,
              ),
              _LanguageLevelSelectorItem(
                value: LanguageEnum.expert,
                onSelect: onChange,
                actualValue: value,
              )
            ],
          )
        ],
      ),
    );
  }
}

class _LanguageLevelSelectorItem extends StatelessWidget {
  final LanguageEnum value;
  final Function onSelect;
  final LanguageEnum actualValue;

  _LanguageLevelSelectorItem({this.value, this.onSelect, this.actualValue});

  bool isSelected() => value == actualValue;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onSelect(value);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
              color: isSelected() ? primaryColor : null,
              border: isSelected() ? null : Border.all(color: inputBorderColor),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Align(
            child: Text(
              getLevelLabel(value),
              style:
                  TextStyle(color: isSelected() ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}

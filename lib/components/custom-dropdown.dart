import 'package:cvmakr/consts.dart';
import 'package:cvmakr/data/data.dart';
import 'package:flutter/material.dart';

const languages = <String>[
  'en',
  'de',
  'fr',
  'it',
  'es',
  'pl',
  'ru',
  'rp',
  'nl',
  'ho',
  'pt',
  'el',
  'sv',
  'cs',
  'zh',
  'ja',
];

//List<DropdownMenuItem> dropDownItems = [];

class CustomDropdown extends StatelessWidget {
  final String value;
  final Function onChange;

  CustomDropdown({this.value, this.onChange});

  List<DropdownMenuItem> buildList() {
    List<DropdownMenuItem> dropDownItems = [];
    languages.forEach(
      (key) => dropDownItems.add(
        DropdownMenuItem(
          child: Row(
            children: <Widget>[
              Image.asset(
                'images/flags/$key.png',
                width: 32,
                height: 32,
              ),
              SizedBox(
                width: 10,
              ),
              Text(Data.translate(key)),
            ],
          ),
          value: key,
        ),
      ),
    );
    return dropDownItems;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: inputBorderColor)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          underline: null,
          value: value,
          items: buildList(),
          onChanged: (value) {
            onChange(value);
          },
        ),
      ),
    );
  }
}

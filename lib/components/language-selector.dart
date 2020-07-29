import 'package:flutter/material.dart';

const languages = <String>[
  'en',
  'fr',
];

//List<DropdownMenuItem> dropDownItems = [];

class LanguageSelector extends StatelessWidget {
  final String value;
  final Function onChange;

  LanguageSelector({this.value, this.onChange});

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
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        //isExpanded: true,
        iconSize: 0,
        underline: null,
        value: value,
        items: buildList(),
        onChanged: (value) {
          onChange(value);
        },
      ),
    );
  }
}

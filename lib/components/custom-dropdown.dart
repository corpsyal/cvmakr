import 'package:cvmakr/consts.dart';
import 'package:flutter/material.dart';

const Map<String, String> languages = {
  'en': "Anglais",
  'de': "Allemand",
  'fr': "Français",
  'it': "Italien",
  'es': "Espagnol",
  'pl': "Polonais",
  'ru': "Russe",
  'rp': "Roumain",
  'nl': "Néerlandais",
  'ho': "Hongrois",
  'pt': "Portugais",
  'el': "Grec",
  'sv': "Suédois",
  'cs': "Tchèque",
  'zh': "Chinois",
  'ja': "Japonais"
};

//List<DropdownMenuItem> dropDownItems = [];

class CustomDropdown extends StatelessWidget {
  final String value;
  final Function onChange;

  CustomDropdown({this.value, this.onChange});

  List<DropdownMenuItem> buildList() {
    List<DropdownMenuItem> dropDownItems = [];
    languages.forEach(
      (key, value) => dropDownItems.add(
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
              Text(value),
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

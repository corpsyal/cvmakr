import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String value;
  final Function onChange;

  CustomDropdown({this.value, this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          underline: null,
          value: value,
          items: [
            DropdownMenuItem(
              child: Row(
                children: <Widget>[
                  Icon(Icons.language),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Français')
                ],
              ),
              value: 'fr',
            ),
            DropdownMenuItem(
              child: Text('Anglais'),
              value: 'en',
            ),
            DropdownMenuItem(
              child: Text('Allemand'),
              value: 'de',
            ),
          ],
          onChanged: (value) {
            onChange(value);
          },
        ),
      ),
    );
  }
}

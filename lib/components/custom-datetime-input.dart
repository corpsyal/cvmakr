import 'package:cvmakr/components/custom-input.dart';
import 'package:cvmakr/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class CustomDateTimeInput extends StatelessWidget {
  Function onConfirm;
  String label;
  String initialValue;

  CustomDateTimeInput({this.onConfirm, this.label, this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: () {
          DatePicker.showDatePicker(
            context,
            //locale: DATETIME_PICKER_LOCALE_DEFAULT,
            dateFormat: 'MMMM-yyyy',
            locale: DateTimePickerLocale.values.firstWhere((locale) {
              print(locale.toString().split('.').last);
              return locale.toString().split('.').last == Data.locale;
            }),
            onConfirm: onConfirm,
          );
        },
        child: IgnorePointer(
          child: CustomInput(
            label: label,
            initialValue: initialValue,
            controlledInput: true,
          ),
        ),
      ),
    );
  }
}

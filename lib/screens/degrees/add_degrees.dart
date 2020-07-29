import 'package:cvmakr/components/custom-button.dart';
import 'package:cvmakr/components/custom-datetime-input.dart';
import 'package:cvmakr/components/custom-input.dart';
import 'package:cvmakr/components/form-container.dart';
import 'package:cvmakr/data/data.dart';
import 'package:cvmakr/data/degree.dart';
import 'package:cvmakr/screens/experiences/add_experiences.dart';
import 'package:cvmakr/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddDegrees extends StatefulWidget {
  static const String id = 'add_degrees';

  final Degree degree;
  final Degree initialDegree;
  final mode degreeMode;

  AddDegrees({Degree degree})
      : this.degree = degree ?? Degree(),
        this.initialDegree = Degree.fromMap((degree ?? Degree()).toJson()),
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
      onWillPop: () => widget.degree.isEqual(widget.initialDegree)
          ? noChange(context)
          : onBack(context),
      title: Data.translate("add_degree"),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CustomInput(
              label: Data.translate("degree"),
              initialValue: widget.degree.degree,
              onChange: (String degree) {
                widget.degree.degree = degree;
              },
            ),
            CustomInput(
              label: Data.translate("school"),
              initialValue: widget.degree.school,
              onChange: (String school) {
                widget.degree.school = school;
              },
            ),
            Row(
              children: <Widget>[
                CustomDateTimeInput(
                    label: Data.translate("from"),
                    initialValue: widget.degree.from != null
                        ? capitalize(dateFormat.format(widget.degree.from))
                        : null,
                    onConfirm: (dateTime, _) {
                      setState(() {
                        widget.degree.from = dateTime;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    }),
                SizedBox(
                  width: 20,
                ),
                CustomDateTimeInput(
                    label: Data.translate("to"),
                    initialValue: widget.degree.to != null
                        ? capitalize(dateFormat.format(widget.degree.to))
                        : null,
                    onConfirm: (dateTime, _) {
                      setState(() {
                        widget.degree.to = dateTime;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    }),
              ],
            ),
            CustomInput(
              label: Data.translate("description"),
              maxLines: 6,
              initialValue: widget.degree.description,
              onChange: (String description) {
                widget.degree.description = description;
              },
            ),
            CustomButton(
              width: double.infinity,
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

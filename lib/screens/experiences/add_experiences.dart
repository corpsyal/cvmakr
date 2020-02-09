import 'package:cvmakr/components/custom-button.dart';
import 'package:cvmakr/components/custom-input.dart';
import 'package:cvmakr/components/form-container.dart';
import 'package:cvmakr/data/data.dart';
import 'package:cvmakr/data/experience.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:provider/provider.dart';

class AddExperiences extends StatelessWidget {
  static const String id = 'add_experiences';

  @override
  Widget build(BuildContext context) {
    Data data = Provider.of<Data>(context);
    Experience experience = Experience();
    //print(data.experiences);
    return FormContainer(
      title: "Ajouter une expérience",
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CustomInput(
              label: "Poste",
              onChange: (String job) {
                experience.job = job;
              },
            ),
            CustomInput(
              label: "Entreprise",
              onChange: (String company) {
                experience.company = company;
              },
            ),
            Row(
              children: <Widget>[
                Flexible(
                    child: InkWell(
                  onTap: () {
                    DatePicker.showDatePicker(
                      context,
                      //locale: DATETIME_PICKER_LOCALE_DEFAULT,
                      dateFormat: 'MMMM-yyyy',
                      locale: DateTimePickerLocale.fr,
                      onConfirm: (dateTime, _) {
                        experience.from = dateTime;
                      },
                    );
                  },
                  child: IgnorePointer(
                    child: CustomInput(
                      label: "De",
                    ),
                  ),
                )),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                    child: InkWell(
                  onTap: () {
                    DatePicker.showDatePicker(
                      context,
                      //locale: DATETIME_PICKER_LOCALE_DEFAULT,
                      dateFormat: 'MMMM-yyyy',
                      locale: DateTimePickerLocale.fr,
                      onConfirm: (dateTime, _) {
                        experience.to = dateTime;
                      },
                    );
                  },
                  child: IgnorePointer(
                    child: CustomInput(
                      label: "Jusque",
                    ),
                  ),
                ))
              ],
            ),
            CustomInput(
              label: "Courte description",
              maxLines: 6,
              onChange: (String description) {
                experience.description = description;
              },
            ),
            CustomButton(
              label: 'Ajouter',
              onPress: () async {
                print(experience.toJson());
                data.addExperience(experience);
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

/*
onPressed: () {
                DatePicker.showDatePicker(context,
                    locale: DATETIME_PICKER_LOCALE_DEFAULT);
              },
 */

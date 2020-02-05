import 'package:cvmakr/components/custom-button.dart';
import 'package:cvmakr/components/custom-input.dart';
import 'package:cvmakr/components/form-container.dart';
import 'package:cvmakr/consts.dart';
import 'package:cvmakr/data/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalInformations extends StatelessWidget {
  static const String id = 'personnal_infos';

  @override
  Widget build(BuildContext context) {
    Data data = Provider.of<Data>(context);
    return FormContainer(
      title: "Informations personnelles",
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 8, bottom: 24),
                child: CircleAvatar(
                  child: Icon(
                    Icons.photo_camera,
                    color: primaryColor,
                  ),
                  //foregroundColor: Colors.white,
                  backgroundColor: Colors.white,
                ),
                width: 96.0,
                height: 96.0,
                padding: const EdgeInsets.all(2.0), // borde width
                decoration: new BoxDecoration(
                  color: primaryColor, // border color
                  shape: BoxShape.circle,
                )),
            CustomInput(
              label: "Nom",
              initialValue: data.lastName,
              onChange: (lastName) => data.lastName = lastName,
            ),
            CustomInput(
              label: "Prénom",
              initialValue: data.firstName,
              onChange: (firstName) => data.firstName = firstName,
            ),
            CustomInput(
              label: "Âge",
              initialValue: data.age,
              onChange: (age) => data.age = age,
              keyboardType: TextInputType.number,
            ),
            CustomInput(
              label: "Ville",
              initialValue: data.city,
              onChange: (city) => data.city = city,
            ),
            CustomInput(
              label: "Email",
              initialValue: data.email,
              onChange: (email) => data.email = email,
            ),
            CustomInput(
              label: "Téléphone",
              initialValue: data.phone,
              onChange: (phone) => data.phone = phone,
            ),
            CustomInput(
              label: "A props de moi",
              initialValue: data.aboutMe,
              onChange: (aboutMe) => data.aboutMe = aboutMe,
              maxLines: 8,
            ),
            CustomButton(
              label: 'Enregistrer',
              onPress: () {
                data.save();
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

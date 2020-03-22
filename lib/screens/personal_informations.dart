import 'dart:io';

import 'package:cvmakr/components/custom-button.dart';
import 'package:cvmakr/components/custom-input.dart';
import 'package:cvmakr/components/form-container.dart';
import 'package:cvmakr/consts.dart';
import 'package:cvmakr/data/data.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class PersonalInformations extends StatefulWidget {
  static const String id = 'personnal_infos';

  @override
  _PersonalInformationsState createState() => _PersonalInformationsState();
}

class _PersonalInformationsState extends State<PersonalInformations> {
  Future getImage(Data data) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        cropStyle: CropStyle.circle,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Ajustement',
            toolbarColor: primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      );

      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocDirPath = appDocDir.path;
      File imageCropped = await croppedFile
          .copy("$appDocDirPath/${p.basename(croppedFile.path)}");

      setState(() {
        data.avatar = imageCropped.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Data data = Provider.of<Data>(context);

    return FormContainer(
      onWillPop: () =>
          data.hasUnsavedChange() ? onBack(context) : noChange(context),
      title: "Informations personnelles",
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () => getImage(data),
              child: data.avatar != null
                  ? Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 16),
                          width: 132,
                          height: 132,
                          child: CircleAvatar(
                            backgroundColor: primaryColor,
                            backgroundImage: Image.file(
                              File(data.avatar),
                            ).image,
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          right: 5,
                          child: GestureDetector(
                            onTap: () => setState(() => data.avatar = null),
                            child: Container(
                              width: 30,
                              height: 30,
                              child: CircleAvatar(
                                backgroundColor: primaryColor,
                                child: Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  : Container(
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: primaryColor, width: 2)),
                      child: Icon(
                        Icons.account_circle,
                        color: primaryColor,
                        size: 132,
                      ),
                    ),
            ),
            Text(
              'Ajouter votre photo',
              style: TextStyle(color: Theme.of(context).hintColor),
            ),
            SizedBox(
              height: 24,
            ),
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
              width: double.infinity,
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

import 'package:cvmakr/components/custom-button.dart';
import 'package:cvmakr/components/custom-dropdown.dart';
import 'package:cvmakr/components/language-level-selector.dart';
import 'package:cvmakr/data/data.dart';
import 'package:cvmakr/data/language.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum languageMode { add, edit }
String getButtonLabel(languageMode m) {
  String label;
  switch (m) {
    case languageMode.add:
      label = "Ajouter";
      break;
    case languageMode.edit:
      label = 'Modifier';
      break;
  }
  return label;
}

Future settingModalBottomSheet(context, Language language,
        {languageMode mode}) =>
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      context: context,
      builder: (BuildContext bottomSheetContext) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        Data data = Provider.of<Data>(context);

        return Padding(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CustomDropdown(
                  value: language.language,
                  onChange: (String newLanguage) {
                    setState(() {
                      language.language = newLanguage;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                LanguageLevelSelector(
                  value: language.level,
                  onChange: (LanguageEnum newLanguageLevel) {
                    setState(() {
                      language.level = newLanguageLevel;
                    });
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: CustomButton(
                        label: "Fermer",
                        isSecondary: true,
                        onPress: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: CustomButton(
                        label: getButtonLabel(mode),
                        onPress: () async {
                          if (mode == languageMode.add)
                            data.addLanguage(language);
                          await data.save();
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                )
              ],
            ));
      }),
    );

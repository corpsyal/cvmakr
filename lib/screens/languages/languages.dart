import 'package:cvmakr/components/form-container.dart';
import 'package:cvmakr/data/data.dart';
import 'package:cvmakr/screens/languages/empty_languages.dart';
import 'package:cvmakr/screens/languages/list_languages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Languages extends StatelessWidget {
  static const String id = 'languages';

  @override
  Widget build(BuildContext context) {
    Data data = Provider.of<Data>(context);
    //print(data.experiences);
    return FormContainer(
      title: "Langues",
      child: data.languages.length > 0 ? ListLanguages() : EmptyLanguages(),
    );
  }
}

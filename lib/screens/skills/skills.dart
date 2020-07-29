import 'package:cvmakr/components/form-container.dart';
import 'package:cvmakr/data/data.dart';
import 'package:cvmakr/screens/skills/empty_skills.dart';
import 'package:cvmakr/screens/skills/list_skills.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Skills extends StatelessWidget {
  static const String id = 'skills';

  @override
  Widget build(BuildContext context) {
    Data data = Provider.of<Data>(context);
    //print(data.experiences);
    return FormContainer(
      title: Data.translate("skills"),
      child: data.skills.length > 0 ? ListSkills() : EmptySkills(),
    );
  }
}

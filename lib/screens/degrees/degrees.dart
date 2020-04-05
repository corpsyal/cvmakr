import 'package:cvmakr/components/form-container.dart';
import 'package:cvmakr/data/data.dart';
import 'package:cvmakr/screens/degrees/empty_degrees.dart';
import 'package:cvmakr/screens/degrees/list_degrees.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Degrees extends StatelessWidget {
  static const String id = 'degrees';

  @override
  Widget build(BuildContext context) {
    Data data = Provider.of<Data>(context);
    //print(data.experiences);
    return FormContainer(
        title: Data.translate("education"),
        child: data.degrees.length > 0 ? ListDegrees() : EmptyDegrees());
  }
}

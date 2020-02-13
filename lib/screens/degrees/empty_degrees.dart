import 'package:cvmakr/screens/degrees/add_degrees.dart';
import 'package:cvmakr/screens/emptyScreen.dart';
import 'package:flutter/material.dart';

class EmptyDegrees extends StatelessWidget {
  static const String id = 'empty_degrees';

  @override
  Widget build(BuildContext context) {
    return EmptyScreen(
      mainLabel: "Pas encore de formations !",
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddDegrees()),
      ),
    );
  }
}

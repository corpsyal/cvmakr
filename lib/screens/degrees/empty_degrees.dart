import 'package:cvmakr/components/empty-screen.dart';
import 'package:cvmakr/data/data.dart';
import 'package:cvmakr/screens/degrees/add_degrees.dart';
import 'package:flutter/material.dart';

class EmptyDegrees extends StatelessWidget {
  static const String id = 'empty_degrees';

  @override
  Widget build(BuildContext context) {
    return EmptyScreen(
      mainLabel: Data.translate("no_degree_yet"),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddDegrees()),
      ),
    );
  }
}

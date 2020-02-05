import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:cvmakr/screens/home.dart';
import 'package:cvmakr/screens/personal_informations.dart';
import 'package:provider/provider.dart';
import 'package:cvmakr/data/data.dart';

import 'screens/home.dart';

Color primaryColor = Color(0xFF8B84FB);
//const String sharedKey = 'personal_infos';
const String sharedKey = 'data';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(primaryColor);
    return FutureBuilder(
        future: Data.restoreData(),
        builder: (context, AsyncSnapshot<Data> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Provider(
              create: (_) => snapshot.data,
              child: MaterialApp(
                  title: 'Flutter Demo',
                  theme: ThemeData(
                      fontFamily: 'Metropolis', primaryColor: primaryColor),
                  home: HomePage()),
            );
          } else {
            return Container();
          }
        });
  }
}

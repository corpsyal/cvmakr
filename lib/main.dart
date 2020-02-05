import 'package:cvmakr/data/data.dart';
import 'package:cvmakr/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'screens/home.dart';

Color primaryColor = Color(0xFF8B84FB);
const String sharedKey = 'data';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: primaryColor, // status bar color
    systemNavigationBarColor: Colors.white, // navigation bar color
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Data.restoreData(),
        builder: (context, AsyncSnapshot<Data> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print(snapshot.data);
            return Provider(
              create: (_) => snapshot.data,
              child: MaterialApp(
                  title: 'cvMakR',
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

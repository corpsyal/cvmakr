import 'package:cvmakr/data/data.dart';
import 'package:cvmakr/screens/home.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' as Intl;
import 'package:provider/provider.dart';

Color primaryColor = Color(0xFF8B84FB);
const String sharedKey = 'data';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // need when async in main
  Intl.Intl.defaultLocale = 'fr';
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: primaryColor, // status bar color
    systemNavigationBarColor: primaryColor, // navigation bar color
  ));

  FirebaseAdMob.instance
      .initialize(appId: 'ca-app-pub-8039402823283760~9402931627');

  //Crashlytics.instance.enableInDevMode = true;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  await initializeDateFormatting("fr_FR", null);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.white, // navigation bar color
            ));

            return ChangeNotifierProvider(
              create: (_) => snapshot.data,
              child: MaterialApp(
                  title: 'cvMakR',
                  theme: ThemeData(
                      fontFamily: 'Metropolis', primaryColor: primaryColor),
                  home: HomePage()),
            );
          } else {
            return Container(
              color: primaryColor,
              child: Center(
                child: RichText(
                  textDirection: TextDirection.ltr,
                  text: TextSpan(
                    text: 'cv',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontFamily: 'Metropolis',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Makr',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}

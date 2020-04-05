import 'package:cvmakr/components/language-selector.dart';
import 'package:cvmakr/components/section-item.dart';
import 'package:cvmakr/consts.dart';
import 'package:cvmakr/data/data.dart';
import 'package:cvmakr/screens/degrees/degrees.dart';
import 'package:cvmakr/screens/experiences/experiences.dart';
import 'package:cvmakr/screens/generate.dart';
import 'package:cvmakr/screens/languages/languages.dart';
import 'package:cvmakr/screens/models/models.dart';
import 'package:cvmakr/screens/personal_informations.dart';
import 'package:cvmakr/screens/skills/skills.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  childDirected: false,
  //childDirected: true,
  nonPersonalizedAds: true,
  testDevices: ['C7B3B7A312CC82A2420D2850E08A2302'],
);

class HomePage extends StatefulWidget {
  static const String id = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool successfulLoad = false;
  bool failedToLoad = false;

  void loadAdd() => RewardedVideoAd.instance.load(
        // adUnitId: RewardedVideoAd.testAdUnitId,
        adUnitId: 'ca-app-pub-8039402823283760/1332869913',
        targetingInfo: targetingInfo,
      );

  void goToGenerate() => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Generate()),
      );

  void setListener(RewardedVideoAdEvent event,
      {String rewardType, int rewardAmount}) {
    if (event == RewardedVideoAdEvent.loaded) {
      setState(() {
        successfulLoad = true;
      });
    }

    if (event == RewardedVideoAdEvent.started) {}

    if (event == RewardedVideoAdEvent.rewarded) {
      goToGenerate();
    }

    if (event == RewardedVideoAdEvent.failedToLoad) {
      setState(() {
        failedToLoad = true;
      });
    }

    if ([
      //RewardedVideoAdEvent.completed,
      RewardedVideoAdEvent.closed,
    ].contains(event)) {
      setState(() {
        successfulLoad = false;
        failedToLoad = false;
      });

      loadAdd();
    }
  }

  @override
  void initState() {
    super.initState();
    // loadAdd();
    RewardedVideoAd.instance.listener = setListener;
    loadAdd();
  }

  @override
  Widget build(BuildContext context) {
    Data data = Provider.of<Data>(context);

    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                        text: "cv",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Makr",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold),
                          )
                        ]),
                  ),
                  LanguageSelector(
                    value: Data.locale,
                    onChange: (newLanguage) => data.switchLanguage(newLanguage),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: SingleChildScrollView(
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SectionItem(
                        title: Data.translate("personal_infos"),
                        iconName: Icons.person_outline,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PersonalInformations()),
                        ),
                      ),
                      SectionItem(
                        title: Data.translate("experiences"),
                        iconName: Icons.domain,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Experiences()),
                        ),
                      ),
                      SectionItem(
                        title: Data.translate("education"),
                        iconName: Icons.school,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Degrees()),
                        ),
                      ),
                      SectionItem(
                        title: Data.translate("skills"),
                        iconName: Icons.assignment,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Skills()),
                        ),
                      ),
                      SectionItem(
                        title: Data.translate("languages"),
                        iconName: Icons.language,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Languages()),
                        ),
                      ),
                      SectionItem(
                        title: Data.translate("models"),
                        iconName: Icons.filter,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Models()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.all(10),
          child: SizedBox(
            height: 70,
            child: RaisedButton(
              //splashColor: Colors.white,
              //highlightColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(8.0),
              ),
              elevation: 0,
              color: primaryColor,
              padding: EdgeInsets.symmetric(vertical: 25.0),
              child: successfulLoad || failedToLoad
                  ? Text(
                      Data.translate("generate"),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  : SpinKitThreeBounce(
                      color: Colors.white,
                      size: 15.0,
                    ),
              onPressed: () async {
                if (successfulLoad)
                  RewardedVideoAd.instance.show();
                else if (failedToLoad) {
                  loadAdd();
                  goToGenerate();
                }
              },
            ),
          ),
        ),
        elevation: 0,
      ),
    );
  }
}

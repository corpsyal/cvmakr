import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

Color primaryColor = Color(0xFF8B84FB);
Color inactivePrimaryColor = Color(0xFFE9E8FC);
Color inputBorderColor = Color(0xFFD6D4D4);
Color secondTextColor = Color(0xFF9A9A9A);

Color selectZoneColor = Color(0xFFEDEEEE);

TextStyle secondaryTextStyle = TextStyle(color: secondTextColor, fontSize: 12);

MobileAdTargetingInfo targetingInfo =
    MobileAdTargetingInfo(childDirected: false);

void loadAdd() {
  RewardedVideoAd.instance.load(
    adUnitId: RewardedVideoAd.testAdUnitId,
    //adUnitId: 'ca-app-pub-8039402823283760/1332869913',
    targetingInfo: targetingInfo,
  );
}

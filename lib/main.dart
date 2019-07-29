import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_std/pages/PgMain.dart';
import 'package:flutter_std/utils/HttpManager.dart';
import 'package:flutter_std/utils/HttpResponseListener.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:path/path.dart';

import 'Help.dart';

void main() {
//  Overlay
//  await AMap.init('71921fa552a5119c74d39fc297f1d2c4');
//  setDesignWHD(750, 1334);
//  ScreenUtil.getInstance();
//  AMap.init('71921fa552a5119c74d39fc297f1d2c4').then((v) {
  // 强制竖屏
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  JPush jPush = new JPush();
  Help.addEventHandler(JPush());
  jPush.applyPushAuthority(
      new NotificationSettingsIOS(sound: true, alert: true, badge: true));
  jPush.setup(
      appKey: "6a30d2dbe744a2281cb285ce",
      channel: "developer-default",
      debug: true,
      production: true);
  Help.init().then((res) async {
    if (Help.ISFIRST == null) {
      runApp(new PgMain(0));
    } else {
      if (res != null) {
        runApp(new PgMain(2));
      } else {
        runApp(new PgMain(1));
      }
    }
  });

//  });
}

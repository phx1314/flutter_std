import 'dart:async';
import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/model/ModelFlowList.dart';
import 'package:flutter_std/model/ModelMenuConfig.dart';
import 'package:flutter_std/model/ModelPush.dart';
import 'package:flutter_std/model/ModelWork.dart';
import 'package:flutter_std/pages/PgHome.dart';
import 'package:flutter_std/pages/PgLogin.dart';
import 'package:flutter_std/pages/PgPubView.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

import 'PgWork.dart';
import 'PgYinDao.dart';

/**
 * 欢迎页
 * Created by guoshuyu
 * Date: 2018-07-16
 */

class PgWelcome extends StatefulWidget {
  static final String sName = "WelcomePage";

  @override
  _PgWelcomeState createState() => _PgWelcomeState();
}

class _PgWelcomeState extends BaseState<PgWelcome> {
  JPush jPush = new JPush();
  String registerId = null;
  String myMsg;

  @override
  void initState() {
    super.initState();
    jPush.setup(
        appKey: "df615cf02ae95c08b6fd10e7",
        channel: "developer-default",
        debug: true,
        production: false);
//    Timer timer = new Timer(new Duration(seconds: 10), () {
//
//    });
    new Future.delayed(const Duration(seconds: 2), () {
      Help.init().then((res) {
        if (Help.ISFIRST == null) {
          Help.pushReplacementNamed(context, PgYinDao.sName);
        } else {
          if (res != null) {
            setPushTag(jPush);
            print("go Main");
//          NavigatorUtils.pushReplacementNamed(context, MainPage.sName);
          } else {
            print("go Login");
            Help.pushReplacementNamed(context, PgLogin.sName);
          }
        }
      });
    });
  }

  setPushTag(JPush mJPush) {
    Help.pushReplacementNamed(context, PgHome.sName);
//    mJPush
//        .setAlias(
//            JPush_Alias_BeginWith + Help.mModelUser.UserInfo.EmpID.toString())
//        .then((v) {
//      print(v.toString());
//      List<String> tags = List<String>();
//      tags.add(JPush_Alias_BeginWith);
//      mJPush.setTags(tags).then((v) {
//        print(v.toString());
////        Help.goWhere(context, PgWork());
//        Help.pushReplacementNamed(context, PgHome.sName);
//      });
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        child: Image(
          image: AssetImage('static/images/loading.png'),
          fit: BoxFit.fill,
        ),
      );
    });
  }
}

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
  int type;

  @override
  _PgWelcomeState createState() => _PgWelcomeState();
}

class _PgWelcomeState extends BaseState<PgWelcome> {
  @override
  void initView() async {
    new Future.delayed(const Duration(seconds: 1), () {
      Help.pushReplacementNamed(
          context,
          widget.type == 0
              ? PgYinDao.sName
              : widget.type == 1 ? PgLogin.sName : PgHome.sName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        color: Colors.white,
        child: Image.asset(
          "static/images/loading.png",
          fit: BoxFit.cover,
        ),
      );
    });
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:bottom_tab_bar/bottom_tab_bar.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/model/ModelCount.dart';
import 'package:flutter_std/model/ModelMenuConfig.dart';
import 'package:flutter_std/model/ModelVersion.dart';
import 'package:flutter_std/model/ModelWork.dart';
import 'package:flutter_std/pages/PgFx.dart';
import 'package:flutter_std/pages/PgNews.dart';
import 'package:flutter_std/pages/PgWode.dart';
import 'package:flutter_std/pages/PgWork.dart';
import 'package:flutter_std/pages/PgXx.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

import 'PgWebView.dart';

class PgHome extends StatefulWidget {
  static final String sName = "PgHome";

  @override
  State<StatefulWidget> createState() {
    return PgHomeState();
  }
}

class PgHomeState extends BaseState<PgHome> {
  int _tabIndex = 0;
  var appBarTitles = ['工作', '发现', '消息', '新闻', '我的'];
  ModelCount mModelCount;
  int _lastClickTime = 0;
  int xxCount = 0;

  Future<bool> _doubleExit() {
    int nowTime = new DateTime.now().microsecondsSinceEpoch;
    if (_lastClickTime != 0 && nowTime - _lastClickTime > 1500) {
      return new Future.value(true);
    } else {
      Help.Toast(context, '再按一次，退出程序');
      _lastClickTime = new DateTime.now().microsecondsSinceEpoch;
      new Future.delayed(const Duration(milliseconds: 1500), () {
        _lastClickTime = 0;
      });
      return new Future.value(false);
    }
  }

  void _changeTab(int index) {
    _tabIndex = index;
    reLoad();
  }

  @override
  void initView() {
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        Help.sendMsg('PgPubView,ItemDialogSub', 889, visible);
      },
    );
    loadUrl(METHOD_UPDATE, {"_api_key": apikey, "appKey": appKey},
        isShow: false, isFormData: true);
  }

  @override
  onSuccess(String methodName, res) {
    if (methodName == METHOD_GetWork) {
      Help.mModelWorkBeans = List();
      ModelWork mModelWork = ModelWork.fromJson(res.data);
      addSon(mModelWork.rows);
      Help.sendMsg("PgBd", 0, '');
    } else if (methodName == METHOD_UPDATE) {
      ModelVersion mModelVersion = ModelVersion.fromJson(res.data);
      PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
        if (int.parse(packageInfo.buildNumber) <
            int.parse(mModelVersion.data.buildVersionNo)) {
          Help.showAlertDialog(context, '发现新版本，是否更新', () {
            launch(mModelVersion.data.buildShortcutUrl);
          });
        }
      });
    }
  }

  void addSon(List<ModelWorkBean> rows) {
    rows.forEach((item) {
      if (item.MenuMobileConfig != "{}") {
        item.mModelMenuConfig =
            ModelMenuConfig.fromJson(json.decode(item.MenuMobileConfig));
        Help.mModelWorkBeans.add(item);
      }
      if (item.children != null) addSon(item.children);
    });
  }

  @override
  void initState() {
    super.initState();
    loadUrl(METHOD_GetWork, null, isShow: false);
  }

  @override
  disMsg(int what, var data) {
    switch (what) {
      case 0:
        mModelCount = data;
        reLoad();
        break;
      case 1:
        _changeTab(data);
        break;
      case 2:
        xxCount = data;
        reLoad();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _doubleExit,
      child: Scaffold(
          body: IndexedStack(
              index: _tabIndex,
              children: <Widget>[PgWork(), PgFx(), PgXx(), PgNews(), PgWode()]),
          bottomNavigationBar: BottomTabBar(
            items: <BottomTabBarItem>[
              BottomTabBarItem(
                icon: Icon(Icons.work),
                title: Text(appBarTitles[0],
                    style: TextStyle(
                        fontSize: 15,
                        color: _tabIndex == 0 ? Help.mColor : Colors.black45)),
                badge: null,
              ),
              BottomTabBarItem(
                  icon: Icon(Icons.widgets),
                  title: Text(appBarTitles[1],
                      style: TextStyle(
                          fontSize: 15,
                          color:
                              _tabIndex == 1 ? Help.mColor : Colors.black45))),
              BottomTabBarItem(
                icon: Icon(Icons.chat_bubble),
                title: Text(appBarTitles[2],
                    style: TextStyle(
                        fontSize: 15,
                        color: _tabIndex == 2 ? Help.mColor : Colors.black45)),
                badge: xxCount > 0
                    ? CircleAvatar(
                        radius: ScreenUtil.getScaleW(context, 9),
                        backgroundColor: Colors.red,
                        child: Text(
                          xxCount.toString(),
                          style: Style.minTextWhite,
                        ),
                      )
                    : null,
              ),
              BottomTabBarItem(
                  icon: Icon(Icons.fiber_new),
                  title: Text(appBarTitles[3],
                      style: TextStyle(
                          fontSize: 15,
                          color:
                              _tabIndex == 3 ? Help.mColor : Colors.black45))),
              BottomTabBarItem(
                icon: Icon(Icons.person),
                title: Text(appBarTitles[4],
                    style: TextStyle(
                        fontSize: 15,
                        color: _tabIndex == 4 ? Help.mColor : Colors.black45)),
                badge: mModelCount != null && mModelCount.Total > 0
                    ? CircleAvatar(
                        radius: ScreenUtil.getScaleW(context, 9),
                        backgroundColor: Colors.red,
                        child: Text(
                          mModelCount.Total.toString(),
                          style: Style.minTextWhite,
                        ),
                      )
                    : null,
              ),
            ],
            type: BottomTabBarType.fixed,
            currentIndex: _tabIndex,
            fixedColor: Help.mColor,
            isAnimation: false,
            isInkResponse: false,
            //点击事件
            onTap: (int a) => _changeTab(a),
          )),
    );
  }
}

import 'dart:convert';
import 'dart:ui';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/model/ModelFlowList.dart';
import 'package:flutter_std/model/ModelMenuConfig.dart';
import 'package:flutter_std/model/ModelPush.dart';
import 'package:flutter_std/model/ModelUser.dart';
import 'package:flutter_std/model/ModelWork.dart';
import 'package:flutter_std/pages/PgPubView.dart';
import 'package:flutter_std/utils/ImageCacheManager.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'az/az_common.dart';
import 'model/ModelAz.dart';

typedef MethodPop = void Function(String v);
typedef MethodAlert = void Function();

const JPush_Alias_BeginWith = "2015001GoldPM9_Default_EmpID_";
//const JPush_Alias_BeginWith = "jqpm_EmpID_";
const PAGE_SIZE = 20;
const DEBUG = true;
const USE_NATIVE_WEBVIEW = true;
const RollupSize_Units = ["GB", "MB", "KB", "B"];

/// //////////////////////////////////////常量////////////////////////////////////// ///
const TOKEN_KEY = "token";
const USER_NAME_KEY = "user-name";
const PW_KEY = "user-pw";
const USER_BASIC_CODE = "user-basic-code";
const USER_INFO = "user-info";
const LANGUAGE_SELECT = "language-select";
const LANGUAGE_SELECT_NAME = "language-select-name";
const REFRESH_LANGUAGE = "refreshLanguageApp";
const THEME_COLOR = "theme-color";
const LOCALE = "locale";
const FILE_DATA = <String>['音频文件', '当前位置', '图片拍照'];
const List colors = [
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.deepOrange,
//  Colors.brown,
//  Colors.blueGrey,
];

/// //////////////////////////////////////常量////////////////////////////////////// ///

const apikey = "848efc235a1f28da65a22edee34bc2a8";
const appKey = "8a1168a00208d1ec6872da12d9a7aa7f";
const METHOD_LOGIN = "core/main/checkuserlogin1";
const METHOD_CUSTOMERSAVE = "bussiness/Customer/save";
const METHOD_CUSTLINKSAVE = "bussiness/CustLink/save";
const METHOD_CUSTLINKMANSAVE = "bussiness/CustLinkMan/save";
const METHOD_CUSTLINKDEL = "bussiness/CustLink/del";
const METHOD_CUSTLINKMANDEL = "bussiness/CustLinkMan/del";
const METHOD_GetToDoList = "core/PubFlow/GetToDoList";
const METHOD_OANEW = "oa/OaNew/json";
const METHOD_GetMails = "Core/Layout/GetMails";
const METHOD_GetImageNews = "core/layout/GetImageNews";
const METHOD_GetWork = "Core/menu/mobilemenujson?level=1&isIcon=true";
const METHOD_OANOTICE = "oa/OaNotice/json";
const METHOD_GetMessages = "oa/Message/GetMessages";
const METHOD_GETLIST = "oa/Message/GetList";
const METHOD_SetReadStatus = "oa/Message/SetReadStatus";
const METHOD_DeleteRead = "oa/Message/DeleteRead";
const METHOD_FLOWWIDGET = "core/PubFlow/FlowWidget";
const METHOD_GETFLOWEXE = "core/PubFlow/GetFlowExe";
const METHOD_GETATTACHFILES = "core/ProcessFile/GetAttachFiles";
const METHOD_EDITINFO = "core/user/editInfo";
const METHOD_UPDATE_USERINFO = "core/User/SaveProfileSetting";
const METHOD_ChangeAvatar1 = "core/user/ChangeAvatar1";
const METHOD_BASELOG = "core/BaseLog/json";
const METHOD_MAILRECEIVEJSON1 = "oa/OaMail/mailreceivejson?Read=0";
const METHOD_MAILRECEIVEJSON2 = "oa/OaMail/mailsendjson";
const METHOD_MAILRECEIVEJSON3 = "oa/OaMail/mailsendjson?Flag=1";
const METHOD_MAILRECEIVEJSON4 = "oa/OaMail/mailjunkjson";
const METHOD_UpdateReadByIds = "/Oa/OaMail/UpdateReadByIds?ids=";
const METHOD_OAMAILDEL = "oa/OaMailRead/del";
const METHOD_OAMAILDELCG = "oa/OaMail/del";
const refTable_OaMail = "OaMail";
const METHOD_OAMAILDETAIL = "oa/OaMail/editInfo";
const METHOD_OAHUIFU = "oa/OaMail/del";
const METHOD_OAHUIFU_READ = "oa/OaMailRead/del";
const METHOD_OAMAIL = "oa/oamail/save";
const METHOD_UPLOAD = "core/ProcessFile/Upload"; //上传文件
const METHOD_DELETE = "core/ProcessFile/Delete"; //删除文件
const method_file_upload = "file/upload";
const method_userchat_add = "userchat/add";
const METHOD_UPDATE = "https://www.pgyer.com/apiv2/app/check";

class Help {
  static var URL = "http://192.168.0.7";
  static var URL_JAVA = "http://192.168.0.195:8001/api";
  static var URL_JAVA_FILE = "http://192.168.0.195:8001/api/file/download/";
  static var BASEURL = "$URL/GoldPM9_jqmis";
//  static var BASEURL = "$URL/GoldPM91_std";
  static var ImageUrl = "$BASEURL/core/main/GetHeadUrl?gid=";
  static var IMAGE_STAR = "$BASEURL/GoldFile/";
  static ModelUser mModelUser;
  static var cookie = "";
  static var ISFIRST = "";
  static final EventBus mEventBus = new EventBus();
  static List<ModelWorkBean> mModelWorkBeans;
  static Color mColor = Colors.blue;
  static ImageCacheManager mImageCacheManager = new ImageCacheManager();

  static init() async {
    try {
      var data = await get("mModelUser");
      ISFIRST = await get("ISFIRST");
      String URL = await get("IP");
      if (URL != null) {
        BASEURL = URL;
      }
      String mColor = await get("mColor");
      if (mColor != null) {
        Help.mColor = colors[int.parse(mColor)];
        Help.sendMsg('PgMain', 0, '');
      }

      if (data == null) {
        return null;
      }
      mModelUser = ModelUser.fromJson(json.decode(data.toString()));
      cookie = "UID=" +
          mModelUser.UserInfo.EmpID.toString() +
          "; " +
          "ASP.NET_SessionId=" +
          mModelUser.SessionID +
          "; " +
          "AgentID=; expires=Fri, 20-May-1983 16:00:00 GMT; path=/";
      ;
      return mModelUser;
    } catch (e) {
      print(e.toString());
    }
  }

  static Future scan(BuildContext context) async {
    try {
      String barcode = await BarcodeScanner.scan();
      Help.Toast(context, barcode);
      print(barcode);
    } catch (e) {
      print(e);
    }
  }

  static addEventHandler(BuildContext context, JPush mJPush) {
//    try {
    mJPush.addEventHandler(onReceiveNotification: (Map<String, dynamic> event) {
      print('addOnreceive>>>>>>$event');
    }, onOpenNotification: (Map<String, dynamic> event) {
      String data = event['extras']['cn.jpush.android.EXTRA'];
      print('addOpenNoti>>>>>$data');
      ModelPush mModelPush = ModelPush.fromJson(json.decode(data));
      if (mModelPush.RefTable == "CreateGroup" ||
          mModelPush.RefTable == "EidtGroup" ||
          mModelPush.RefTable == "DelGroup" ||
          mModelPush.RefTable == "OaMess" ||
          mModelPush.RefTable == "OaMail") return;
      RowsListBean item = new RowsListBean();
      item.Id = int.parse(mModelPush.RefID);

      for (int j = 0; j < Help.mModelWorkBeans.length; j++) {
        if (Help.mModelWorkBeans[j].MenuMobileConfig
                .contains(mModelPush.RefTable) &&
            mModelPush.RefTable ==
                Help.mModelWorkBeans[j].mModelMenuConfig.flow.refTable) {
          item.text = Help.mModelWorkBeans[j].text;
          item.mModelMenuConfig = ModelMenuConfig.fromJson(json.decode(
              Help.getRightdata(Help.mModelWorkBeans[j].MenuMobileConfig,
                  json.decode(data))));
          break;
        }
      }

      Help.go2PubView(context, item, "");
    }, onReceiveMessage: (Map<String, dynamic> event) {
      print('addReceiveMsg>>>>>$event'); //无效的
    });
//    } catch (e) {
//      print(e.toString());
//    }
  }

  static String getRightdata(String data, Map map) {
    try {
      data = data.replaceAllMapped(RegExp("#\\{([^}]*)\\}"), (match) {
        return map[match.group(0).substring(2, match.group(0).length - 1)]
            .toString();
      });
//      RegExp megExp = new RegExp("#\\{([^}]*)\\}");
//      Iterable<Match> mmRegExps = mRegExp.allMatches(data);
//      for (Match m in mmRegExps) {
//        String match = m.group(0);
//        data.replaceAll("#\\{([^}]*)\\}", replace)
//        print(match);
//      }
      return data;
    } catch (e) {
      print(e.toString());
    }
  }

  static showAlertDialog(
      BuildContext context, String title, MethodAlert mMethodAlert) {
    showDialog(
        context: context,
        builder: (_) =>
            new CupertinoAlertDialog(title: new Text(title), actions: <Widget>[
              new FlatButton(
                child: new Text("取消"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("确认"),
                onPressed: () {
                  Navigator.of(context).pop();
                  mMethodAlert();
                },
              )
            ]));
  }

  static closeKeyBord(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Future<Null> showMyDialog(BuildContext context, Widget mWidget) {
    return showDialog(
        context: context, builder: (BuildContext context) => mWidget);
  }

  static Future<Null> showLoadingDialog(BuildContext context) {
    if (context != null)
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return new Material(
                color: Colors.transparent,
                child: WillPopScope(
                  onWillPop: () => new Future.value(true),
                  child: Center(
                    child: new Container(
//                    width: ScreenUtil().setWidth(200),
//                    height: ScreenUtil().setWidth(180),
                      padding:
                          new EdgeInsets.all(ScreenUtil.getScaleW(context, 2)),
                      decoration: new BoxDecoration(
                        color: Colors.transparent,
                        //用一个BoxDecoration装饰器提供背景图片
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.white))),
//                        new Container(height: ScreenUtil().setWidth(20)),
//                        new Container(
//                            alignment: Alignment.center,
//                            child: new Text('正在加载,请稍后...',
//                                style: Style.smallTextWhite)),
                        ],
                      ),
                    ),
                  ),
                ));
          });
  }

  static save(String key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  static remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear(); //清空键值对
  }

  ///替换
  static pushReplacementNamed(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  ///切换无参数页面
  static pushNamed(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  static go2PubView(
      BuildContext context, RowsListBean mRowsListBean, String statusID) {
    goWhere(context, PgPubView(mRowsListBean, statusID));
  }

  static goWhere(BuildContext context, Widget widget) {
    return Navigator.push(
        context, new CupertinoPageRoute(builder: (context) => widget));
//    return Navigator.push(
//        context, new MaterialPageRoute(builder: (context) => widget));
  }

  static Toast(BuildContext context, String msg) {
    Fluttertoast.showToast(msg: msg);
  }

  static void sendMsg(String f, int w, dynamic d) {
    f.split(',').forEach((f) {
      Help.mEventBus.fire([f, w, d]);
    });
  }

  static String getRollupSize(int size) {
    if (size == null) size = 0;
    int idx = 3;
    int r1 = 0;
    String result = "";
    while (idx >= 0) {
      int s1 = size % 1024;
      size = size >> 10;
      if (size == 0 || idx == 0) {
        r1 = (r1 * 100) ~/ 1024;
        if (r1 > 0) {
          if (r1 >= 10)
            result = "$s1.$r1${RollupSize_Units[idx]}";
          else
            result = "$s1.0$r1${RollupSize_Units[idx]}";
        } else
          result = s1.toString() + RollupSize_Units[idx];
        break;
      }
      r1 = s1;
      idx--;
    }
    return result;
  }

  static String matchDate(String date) {
    try {
      RegExp mRegExp = new RegExp("/Date\\((.*)\\)/");
      Iterable<Match> mmRegExps = mRegExp.allMatches(date);
      for (Match m in mmRegExps) {
        DateTime d = DateTime.fromMicrosecondsSinceEpoch(
            int.parse(m.group(1).toString()));
        print("${d.year}-${d.month}-${d.day}");
        return "${d.year}-${d.month < 10 ? '0' + d.month.toString() : d.month}-${d.day < 10 ? '0' + d.day.toString() : d.day}";
      }
    } catch (e) {
      return "";
    }
  }

  static String getDate(String date) {
    DateTime d = DateTime.parse(date);
    return "${d.year}-${d.month < 10 ? '0' + d.month.toString() : d.month}-${d.day < 10 ? '0' + d.day.toString() : d.day}";
  }

  static String getCurrentTime({type = 0, DateTime d}) {
    if (d == null) d = DateTime.now();
    if (type == 0) {
      return "${d.year}-${d.month < 10 ? '0' + d.month.toString() : d.month}-${d.day < 10 ? '0' + d.day.toString() : d.day}";
    } else {
      return "${d.year}-${d.month < 10 ? '0' + d.month.toString() : d.month}-${d.day < 10 ? '0' + d.day.toString() : d.day} ${d.hour < 10 ? '0' + d.hour.toString() : d.hour}:${d.minute < 10 ? '0' + d.minute.toString() : d.minute}:${d.second < 10 ? '0' + d.second.toString() : d.second}";
    }
  }

  static void showPop(
      BuildContext context, List<String> data, MethodPop methodPop,
      {double left = 0,
      double top = 0,
      double right = 0,
      double bottom = 0,
      List<Widget> child}) async {
    List<PopupMenuEntry<String>> items = new List();
    for (int i = 0; i < data.length; i++) {
      items.add(PopupMenuItem<String>(
        value: data[i],
        child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: child != null ? child[i] : Text(data[i])),
      ));
      items.add(PopupMenuDivider(height: 1.0));
    }
    items.removeLast();
    await showMenu(
            context: context,
            position: RelativeRect.fromLTRB(
                left,
                MediaQueryData.fromWindow(window).padding.top +
                    AppBar().preferredSize.height +
                    top,
                right,
                bottom),
            items: items)
        .then((v) {
      methodPop(v);
    });
  }

  static ModelAz getModelAz(List<BaseEmployeeListBean> data, String bm) {
    List<BaseEmployeeListBean> mBaseEmployee =
        (json.decode(json.encode(data)) as List)
            .map((i) => BaseEmployeeListBean.fromJson(i))
            .toList();
    mBaseEmployee.forEach((f) {
      String tag =
          PinyinHelper.getFirstWordPinyin(bm == '0' ? f.EmpName : f.EmpDepName)
              .substring(0, 1)
              .toUpperCase();
      if (RegExp("[A-Z]").hasMatch(tag)) {
        f.tagIndex = tag;
      } else {
        f.tagIndex = "#";
      }
    });
    SuspensionUtil.sortListBySuspensionTag(mBaseEmployee);
    String _suspensionTag = "";
    if (data.length > 0) {
      _suspensionTag = PinyinHelper.getFirstWordPinyin(bm == '0'
              ? mBaseEmployee[0].EmpName
              : mBaseEmployee[0].EmpDepName)
          .substring(0, 1)
          .toUpperCase();
    }

    return ModelAz(mBaseEmployee, _suspensionTag);
  }
}

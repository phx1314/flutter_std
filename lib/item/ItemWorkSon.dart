import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/model/ModelMenuConfig.dart';
import 'package:flutter_std/model/ModelWork.dart';
import 'package:flutter_std/pages/PgEmailList.dart';
import 'package:flutter_std/pages/PgFlowList.dart';
import 'package:flutter_std/pages/PgRz.dart';
import 'package:flutter_std/utils/FontString.dart';
import 'package:flutter_std/utils/GSYStyle.dart';

class ItemWorkSon extends StatelessWidget {
  ModelWorkBean item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _onTap(context);
      },
      child: Container(
        padding: EdgeInsets.only(
            top: ScreenUtil.getScaleW(context,10), bottom: ScreenUtil.getScaleW(context,10)),
        width: ScreenUtil.getScaleW(context,85),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(
                          ScreenUtil.getScaleW(context,2), ScreenUtil.getScaleW(context,2)),
                      blurRadius: ScreenUtil.getScaleW(context,5),
                      spreadRadius: ScreenUtil.getScaleW(context,1)),
                ],
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: ScreenUtil.getScaleW(context,30),
                backgroundColor: FontString.data[item.iconCls
                            .split(" ")[1]
                            .replaceAll("-", "_")
                            .split("_")[1]
                            .substring(0, 1)] ==
                        null
                    ? Colors.blue
                    : FontString.data[item.iconCls
                        .split(" ")[1]
                        .replaceAll("-", "_")
                        .split("_")[1]
                        .substring(0, 1)],
                child: Icon(
                  IconData(
                      FontString.data[
                          item.iconCls.split(" ")[1].replaceAll("-", "_")],
                      fontFamily: FontString.fontFamily),
                  size: ScreenUtil.getScaleW(context,27),
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              height: ScreenUtil.getScaleW(context,7),
            ),
            Text(
              item.text,
              style: Style.text_style_13_gray,
            )
          ],
        ),
      ),
    );
  }

  ItemWorkSon(this.item);

  _onTap(BuildContext context) {
    if (item.children != null) {
      showDiaolg(context);
//      WidgetsBinding.instance.addPostFrameCallback((_) => showDiaolg(context));
    } else {
      go2Where(context);
    }
  }

  void go2Where(BuildContext context) {
    Navigator.pop(context);
    try {
      item.mModelMenuConfig =
          ModelMenuConfig.fromJson(json.decode(item.MenuMobileConfig));
    } catch (e) {}

    if (item.MenuNameEng == "MailReceive") {
      Help.goWhere(context, PgEmailList(type: 1));
    } else if (item.MenuNameEng == "OaCheckList") {
      return;
    } else if (item.MenuNameEng == "MailSend") {
      //发件箱
      Help.goWhere(context, PgEmailList(type: 2));
    } else if (item.MenuNameEng == "MailDraft") {
      //草稿箱
      Help.goWhere(context, PgEmailList(type: 3));
    } else if (item.MenuNameEng == "MailJunk") {
      //垃圾箱
      Help.goWhere(context, PgEmailList(type: 4));
    } else if (item.MenuNameEng == "MailWrite") {
      //写邮件
    } else if (item.MenuNameEng == "OaNewsInfo") {
      //新闻管理
      Help.sendMsg("PgHome", 1, 3);
    } else if (item.MenuNameEng == "LoginLog") {
      //审计
      Help.goWhere(context, PgRz(1));
    } else if (item.MenuNameEng == "BUSSLog") {
      //业务
      Help.goWhere(context, PgRz(0));
    } else if (item.MenuNameEng == "OaScheduler") {
      //工作
    } else {
      Help.goWhere(context, PgFlowList(item));
    }
  }

  void showDiaolg(BuildContext context) {
    List<Widget> mWidgets = new List();
    item.children.forEach((f) {
      mWidgets.add(
        ItemWorkSon(f),
      );
    });
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(item.text),
              titleTextStyle: Style.text_style_16_black,
              titlePadding: EdgeInsets.all(ScreenUtil.getScaleW(context,17)),
              contentPadding: EdgeInsets.all(ScreenUtil.getScaleW(context,2)),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: ScreenUtil.getScaleW(context,300),
                child: Container(
                  child: ListView(
                    children: <Widget>[
                      Divider(height: ScreenUtil.getScaleW(context,1)),
                      Wrap(
                        spacing: ScreenUtil.getScaleW(context,4),
                        // gap between adjacent chips
                        runSpacing: ScreenUtil.getScaleW(context,2),
                        // gap between lines
                        children: mWidgets,
                      )
                    ],
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(ScreenUtil.getScaleW(context,12))),
              ),
            ));
  }
}

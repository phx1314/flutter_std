import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/model/ModelFlowList.dart';
import 'package:flutter_std/pages/PgGjkh.dart';
import 'package:flutter_std/pages/PgWebDetail.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';

class ItemBase extends StatefulWidget {
  RowsListBean item;

  ItemBase(this.item);

  @override
  ItemBaseState createState() => new ItemBaseState();
}

class ItemBaseState extends BaseState<ItemBase> {
  List<Widget> mWidgets = List();

  @override
  void loadData() {
    try {
      mWidgets.clear();
      List responseJson = json.decode(widget.item.FlowSummary);
      for (int i = 0; i < responseJson.length; i++) {
        mWidgets.add(Padding(
          padding: EdgeInsets.only(top: 5),
          child: i == responseJson.length - 1
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      '${responseJson[i]['Key']}  :  ${responseJson[i]['Value']}',
                      style: Style.text_style_13_gray,
                      softWrap: true,
                    ),
                    Expanded(
                        child: Text(
                      widget.item.CreationTime,
                      textAlign: TextAlign.end,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Style.text_style_13_gray,
                      softWrap: true,
                    ))
                  ],
                )
              : Text(
                  i == 0
                      ? '${responseJson[i]['Value']}'
                      : '${responseJson[i]['Key']}  :  ${responseJson[i]['Value']}',
                  style: i == 0
                      ? Style.text_style_16_black
                      : Style.text_style_13_gray,
                  softWrap: true,
                ),
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.item.MenuNameEng == "CustomerInfo" ||
            widget.item.MenuNameEng == "CustPool") {
          //跟进客户
          Help.goWhere(context, PgGjkh(widget.item, widget.item.Id.toString()));
        } else if (widget.item.mModelMenuConfig != null) {
          Help.go2PubView(context, widget.item, "");
        } else {
          Help.goWhere(
              context,
              PgWebDetail(
                  widget.item.Id, "OaNotice", "oa/oanoticemobile/Query"));
        }
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(ScreenUtil.getScaleW(context, 8), 0,
            ScreenUtil.getScaleW(context, 8), ScreenUtil.getScaleW(context, 8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: mWidgets,
        ),
      ),
    );
  }
}

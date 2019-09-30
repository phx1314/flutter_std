import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/model/ModelHt.dart';
import 'package:flutter_std/model/ModelUU.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';

import '../Help.dart';

class ItemGZH extends StatefulWidget {
  ModelUU item;

  ItemGZH(this.item);

  @override
  ItemGZHState createState() => new ItemGZHState();
}

class ItemGZHState extends BaseState<ItemGZH> {
  @override
  void loadData() {
    if (widget.item.Name == null) {
      loadUrl(
          "https://api.weixin.qq.com/cgi-bin/user/info?access_token=${Help.TOKEN}&openid=${widget.item.Id}&lang=zh_CN",
          null);
    }
  }

  @override
  void onSuccess(String methodName, res) {
    widget.item.Name = res.data['nickname'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Help.OPID = widget.item.Id;
        Help.Toast(context, "绑定成功");
      },
      child: Container(
        padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.item.Name ?? "",
              style: Style.text_style_16_black,
            )
          ],
        ),
      ),
    );
  }
}

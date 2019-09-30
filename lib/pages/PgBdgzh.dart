import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/item/ItemGZH.dart';
import 'package:flutter_std/model/ModelAccessToken.dart';
import 'package:flutter_std/model/ModelSon.dart';
import 'package:flutter_std/model/ModelUU.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/PullListView.dart';

class PgBdgzh extends StatefulWidget {
  @override
  PgBdgzhState createState() => new PgBdgzhState();
}

class PgBdgzhState extends BaseState<PgBdgzh> {
  PullListView mPullListView;

  @override
  void initView() {}

  @override
  void loadData() {
    loadUrl(
        "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wx5a8f2d3422d8ce81&secret=3946a84806823e656e549f9bc9950d97",
        null);
  }

  @override
  void onSuccess(String methodName, res) {
    if (methodName ==
        "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wx5a8f2d3422d8ce81&secret=3946a84806823e656e549f9bc9950d97") {
      ModelAccessToken mModelAccessToken = ModelAccessToken.fromJson(res.data);
      Help.TOKEN = mModelAccessToken.accessToken;
      mPullListView = PullListView(
        methodName:
            "https://api.weixin.qq.com/cgi-bin/user/get?access_token=${mModelAccessToken.accessToken}&next_openid=",
        mCallback: (methodName, res) {
          ModelSon mModelNewsList = ModelSon.fromJson(res.data);
          List data = new List();
          mModelNewsList.data.openid.forEach((item) {
            ModelUU mModelUU = new ModelUU(item);
            data.add(new ItemGZH(mModelUU));
          });
          return data;
        },
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('绑定公众号'),
        actions: <Widget>[
          InkWell(
            onTap: () {
              if (Help.OPID == "") {
                Help.Toast(context, "请先绑定账号");
                return;
              }
              loadUrl(
                  "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=" +
                      Help.TOKEN,
                  {
                    "touser": Help.OPID,
                    "msgtype": "text",
                    "text": {"content": "Hello World"}
                  },
                  isFormData: false);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(
                '发消息',
              ),
            ),
          )
        ],
      ),
      body: mPullListView ?? Container(),
    );
  }
}

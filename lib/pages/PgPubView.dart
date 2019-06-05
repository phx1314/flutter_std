import 'dart:convert';
import 'dart:ui';

import 'package:crypto/crypto.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/item/ItemDialogSub.dart';
import 'package:flutter_std/model/ModelFjList.dart';
import 'package:flutter_std/model/ModelFlowList.dart';
import 'package:flutter_std/model/ModelJDInfo.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'PgFileList.dart';
import 'PgFileListEdit.dart';
import 'PgGzjd.dart';

//  https://github.com/tiagojencmartins/unicornspeeddial
class PgPubView extends StatefulWidget {
  var item;
  String statusID;

  PgPubView(this.item, this.statusID);

  @override
  PgPubViewState createState() => new PgPubViewState();
}

class PgPubViewState extends BaseState<PgPubView> {
  String title;
  FlutterWebviewPlugin flutterWebViewPlugin = new FlutterWebviewPlugin();
  RaisedButton mRaisedButton_tj;
  RaisedButton mRaisedButton_bc;
  RaisedButton mRaisedButton_zc;
  RaisedButton mRaisedButton_back;
  RaisedButton mRaisedButton_yj;
  RaisedButton mRaisedButton_fj;
  RaisedButton mRaisedButton_finishi;
  RaisedButton mRaisedButton_hr;
  List<Widget> children = List();
  ModelJDInfo mModelJDInfo;
  ModelFjList mModelFjList;
  Map<String, dynamic> map_json;
  bool isFinish = false;

  @override
  void disMsg(int what, data) {
    switch (what) {
      case 300:
        Map<String, dynamic> map = data;
        map['_processor'] = widget.item.mModelMenuConfig.flow.processor;
//        if (widget.item.FlowRefTable.equals(refTable_CarUse) && (mRowsBean._action.equals("load_next") || mRowsBean._action.equals("save"))) {//用车
//          mModelAddPub.hFormType = "SetCar";
//        }
        if (mModelFjList.rows.length > 0) {
          String uploadFile = "";
          uploadFile += "&lt;Root&gt;&lt;Files RefTable=\"" +
              widget.item.refTable_file +
              "\"&gt;&lt;";
          mModelFjList.rows.forEach((mRowsBean) {
            uploadFile += "File FileName=\"" +
                mRowsBean.Name +
                "\" LastModifiedTime=\"" +
                Help.getCurrentTime(type: 1) +
                "\"&gt;" +
                mRowsBean.IDD +
                "&lt;/File&gt;&lt;";
          });
          uploadFile += "/Files&gt;&lt;/Root&gt;";
          map["\$uplohad\$_cache_y12\$t1m"] = uploadFile;
        }
        map_json.addAll(map);
        loadUrl(METHOD_FLOWWIDGET, map_json);
        break;
      case 889:
        flutterWebViewPlugin.resize(Rect.fromLTRB(
            0,
            MediaQueryData.fromWindow(window).padding.top +
                AppBar().preferredSize.height,
            MediaQuery.of(context).size.width,
            data
                ? MediaQuery.of(context).size.height -
                    ScreenUtil.getScaleW(context, 270)
                : MediaQuery.of(context).size.height -
                    ScreenUtil.getScaleW(
                        context, mModelFjList != null ? 100 : 70)));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context).isCurrent) {
      flutterWebViewPlugin?.show();
      print("显示" + ModalRoute.of(context).toString());
    } else {
      flutterWebViewPlugin?.hide();
      print("隐藏" + ModalRoute.of(context).toString());
    }
    return WebviewScaffold(
      withJavascript: true,
      clearCache: true,
      clearCookies: true,
      url: widget.item.Id != 0
          ? "${Help.BASEURL}/${widget.item.mModelMenuConfig.grid.editUrl}&a=${Help.mModelUser.name}&p=${md5.convert(utf8.encode(Help.mModelUser.password)).toString()}"
          : "${Help.BASEURL}/${widget.item.mModelMenuConfig.grid.addUrl}?a=${Help.mModelUser.name}&p=${md5.convert(utf8.encode(Help.mModelUser.password)).toString()}",
      //      url:"http://192.168.0.7/GoldPM9_hncsxy/oa/OaCarmobile/add?a=%E9%99%88%E9%9C%B2&p=1A1DC91C907325C69271DDF0C944BC72",
      initialChild: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Center(
                  child: CupertinoActivityIndicator(
                    animating: true,
                  ),
                ),
              ),
            ),
            () {
              if (isFinish) {
                return Container();
              } else {
                return Container(
                  child: Column(
                    children: <Widget>[
                      Divider(
                        height: 1,
                      ),
                      Visibility(
                        child: InkWell(
                          onTap: () {
                            if ((mModelJDInfo != null &&
                                    mModelJDInfo.StepOrder == 1) ||
                                widget.item.Id == 0) {
                              Help.goWhere(
                                  context,
                                  PgFileListEdit(
                                      widget.item.Id.toString(),
                                      widget.item.refTable_file,
                                      widget.toString(),
                                      mModelFjList.rows));
                            } else {
                              Help.goWhere(
                                  context,
                                  PgFileList(widget.item.Id.toString(),
                                      widget.item.refTable_file));
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(
                                ScreenUtil.getScaleW(context, 10)),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    '附件列表',
                                    style: Style.text_style_16_black,
                                  ),
                                ),
                                CircleAvatar(
                                  radius: ScreenUtil.getScaleW(context, 11),
                                  backgroundColor: Colors.red,
                                  child: Text(
                                    mModelFjList == null
                                        ? '0'
                                        : mModelFjList.rows.length.toString(),
                                    style: Style.text_style_13_white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        visible: mModelFjList != null,
                      ),
                      Divider(
                        height: 1,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: ScreenUtil.getScaleW(context, 7)),
                        child: Row(
                          children: children,
                        ),
                      )
                    ],
                  ),
                );
              }
            }()
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(widget.item.text),
        centerTitle: true,
        actions: <Widget>[
          InkWell(
            onTap: () {
              Help.goWhere(
                  context,
                  PgGzjd(widget.item.FlowID == null
                      ? '0'
                      : widget.item.FlowID.toString()));
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                '查看进度',
                style: Style.text_style_14_white,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  onSuccess(String methodName, res) {
    if (methodName == 'getApi') {
      mModelJDInfo = ModelJDInfo.fromJson(json.decode(res.json));
      if (((mModelJDInfo?.IsFinished || mModelJDInfo?.IsFlowFinished)) ||
          widget.statusID == '1') {
        isFinish = true;
      }
      flutterWebViewPlugin.resize(Rect.fromLTRB(
          0,
          MediaQueryData.fromWindow(window).padding.top +
              AppBar().preferredSize.height,
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height -
              (isFinish
                  ? 0
                  : ScreenUtil.getScaleW(
                      context, mModelFjList != null ? 100 : 70))));

      mModelJDInfo.AllowEditControls = widget.statusID == '0'
          ? ""
          : mModelJDInfo.AllowEditControls == null
              ? ''
              : mModelJDInfo.AllowEditControls.replaceAll(",", ";");
      mModelJDInfo.SignDatas = mModelJDInfo.SignDatas?.replaceAll("\"", "\\\"");
      widget.item.IsNew = mModelJDInfo.IsNew;
      widget.item.FlowNodeID = mModelJDInfo.FlowNodeID;
      widget.item.FlowMultiSignID = mModelJDInfo.FlowMultiSignID;
      widget.item.FlowID = mModelJDInfo.FlowID;

      if (mModelJDInfo.NextAction > 0) {
        children.insert(0, Padding(padding: EdgeInsets.all(2)));
        children.insert(1, Expanded(child: mRaisedButton_tj));
      }
      if (mModelJDInfo.BackAction > 0) {
        addButton(mRaisedButton_back);
      }
      if (!mModelJDInfo.IsNew) {
        addButton(mRaisedButton_yj);
      }
      if (mModelJDInfo.RejectAction > 0) {
        addButton(mRaisedButton_fj);
      }
      if (mModelJDInfo.FinishAction > 0) {
        addButton(mRaisedButton_finishi);
      }
      if (mModelJDInfo.ChangeAction > 0) {
        addButton(mRaisedButton_hr);
      }
      flutterWebViewPlugin.evalJavascript(
          "initFormBegin('${json.encode(mModelJDInfo.toJson())}')");
      reLoad();
    } else if (methodName == METHOD_GETATTACHFILES) {
      mModelFjList = ModelFjList.fromJson(json.decode(res.json));
      reLoad();
    } else if (methodName == METHOD_FLOWWIDGET) {
      Fluttertoast.showToast(msg: ":处理成功");
      Help.sendMsg('PgFlowList', 0, '');
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    flutterWebViewPlugin.dispose();
    super.dispose();
  }

  void addButton(RaisedButton mRaisedButton) {
    children.add(Padding(padding: EdgeInsets.all(2)));
    children.add(Expanded(child: mRaisedButton));
    reLoad();
  }

  @override
  void initView() {
    mRaisedButton_tj = RaisedButton(
      shape: const RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      elevation: 5,
      padding: EdgeInsets.all(10),
      color: Colors.lightBlue,
      onPressed: () {
        widget.item.action = 'load_next';
        title = '提交';
        flutterWebViewPlugin.evalJavascript("validateFormBegin()");
      },
      child: Text(
        '提交',
        style: Style.text_style_13_white,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
    mRaisedButton_bc = RaisedButton(
      shape: const RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      elevation: 5,
      padding: EdgeInsets.all(10),
      color: Colors.lightBlue,
      onPressed: () {
        widget.item.action = 'load_next';
        title = '保存';
        flutterWebViewPlugin.evalJavascript("validateFormBegin()");
      },
      child: Text(
        '保存',
        style: Style.text_style_13_white,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
    mRaisedButton_zc = RaisedButton(
      shape: const RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      elevation: 5,
      padding: EdgeInsets.all(10),
      color: Colors.lightBlue,
      onPressed: () {
        widget.item.action = 'save';
        title = '暂存';
        flutterWebViewPlugin.evalJavascript("validateFormBegin()");
      },
      child: Text(
        '暂存',
        style: Style.text_style_13_white,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
    mRaisedButton_back = RaisedButton(
      shape: const RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      elevation: 5,
      padding: EdgeInsets.all(10),
      color: Colors.lightBlue,
      onPressed: () {
        widget.item.action = 'load_back';
        title = '回退';
        flutterWebViewPlugin.evalJavascript("noValidateFormBegin()");
      },
      child: Text(
        '回退',
        style: Style.text_style_13_white,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
    mRaisedButton_yj = RaisedButton(
      shape: const RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      elevation: 5,
      padding: EdgeInsets.all(10),
      color: Colors.lightBlue,
      onPressed: () {
        widget.item.action = 'load_transfer';
        title = '移交';
        flutterWebViewPlugin.evalJavascript("noValidateFormBegin()");
      },
      child: Text(
        '移交',
        style: Style.text_style_13_white,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
    mRaisedButton_fj = RaisedButton(
      shape: const RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      elevation: 5,
      padding: EdgeInsets.all(10),
      color: Colors.lightBlue,
      onPressed: () {
        widget.item.action = 'load_reject';
        title = '否决';
        flutterWebViewPlugin.evalJavascript("noValidateFormBegin()");
      },
      child: Text(
        '否决',
        style: Style.text_style_13_white,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
    mRaisedButton_finishi = RaisedButton(
      shape: const RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      elevation: 5,
      padding: EdgeInsets.all(10),
      color: Colors.lightBlue,
      onPressed: () {
        widget.item.action = 'load_finish';
        title = '直接完成';
        flutterWebViewPlugin.evalJavascript("validateFormBegin()");
      },
      child: Text(
        '完成',
        style: Style.text_style_13_white,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
    mRaisedButton_hr = RaisedButton(
      shape: const RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      elevation: 5,
      padding: EdgeInsets.all(10),
      color: Colors.lightBlue,
      onPressed: () {
        widget.item.action = 'load_change';
        title = '换人';
        flutterWebViewPlugin.evalJavascript("noValidateFormBegin()");
      },
      child: Text(
        '换人',
        style: Style.text_style_13_white,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  void go2Where(String type) {
    try {
      if (type == '001') {
        FocusScope.of(context).requestFocus(FocusNode());
        flutterWebViewPlugin?.hide();
        Help.showMyDialog(context,
                ItemDialogSub(widget.toString(), title, widget.item, false))
            .then((v) {
          flutterWebViewPlugin?.show();
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void loadData() {
    widget.item.refTable_file =
        widget.item.FlowRefTable = widget.item.mModelMenuConfig.flow.refTable;
    try {
      if (widget.item.mModelMenuConfig.uploaders != null &&
          widget.item.mModelMenuConfig.uploaders.length > 0) {
        widget.item.refTable_file =
            widget.item.mModelMenuConfig.uploaders[0].refTable;
        loadUrl (METHOD_GETATTACHFILES,
            {"refID": widget.item.Id, "refTable": widget.item.refTable_file},
            isShow: false);
      }
    } catch (e) {
      print(e);
    }
    flutterWebViewPlugin.onChannel.listen((data) {
      print(data);
      map_json = json.decode(data);
      go2Where(map_json['type']);
    });
    flutterWebViewPlugin.onDestroy.listen((aa) {
      Navigator.pop(context);
    });
    flutterWebViewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        flutterWebViewPlugin?.show();
        if (widget.item.mModelMenuConfig.flow.processor.isNotEmpty) {
          if (widget.item.mModelMenuConfig.flow.isShowSave) {
            addButton(mRaisedButton_zc);
          }
          loadUrl(
              METHOD_FLOWWIDGET,
              {
                "_refID": widget.item.Id.toString(),
                "_refTable": widget.item.FlowRefTable,
                "_flowNodeID": 0,
                "_action": "load",
                "_flowMultiSignID": 0
              },
              isShow: false,
              biaoshi: "getApi");
        } else {
          addButton(mRaisedButton_bc);
        }
      } else if (state.type == WebViewState.startLoad) {
        flutterWebViewPlugin?.hide();
      }
    });
  }
}

import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/item/ItemRz.dart';
import 'package:flutter_std/model/ModelMenuConfig.dart';
import 'package:flutter_std/model/ModelSearch.dart';
import 'package:flutter_std/model/ModelRz.dart';
import 'package:flutter_std/model/ModelSearchGk.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/PullListView.dart';

import 'PgSearch.dart';

class PgRz extends StatefulWidget {
  int type;

  PgRz(this.type);

  @override
  PgRzState createState() => new PgRzState();
}

class PgRzState extends BaseState<PgRz> with SingleTickerProviderStateMixin {
  List<Tab> tabs = new List();
  List<Widget> widgets = new List();
  PullListView mPullListView1;
  PullListView mPullListView2;
  TabController mTabController;
  PageController mPageController;

  @override
  void initView() {
    tabs.add(Tab(
      text: "业务日志",
    ));
    tabs.add(Tab(
      text: "审计日志",
    ));
    mPullListView1 = PullListView(
      methodName: METHOD_BASELOG,
      other: _getquary(1),
      mCallback: _callBack,
    );
    mPullListView2 = PullListView(
      methodName: METHOD_BASELOG,
      other: _getquary(0),
      mCallback: _callBack,
    );
    widgets.add(mPullListView1);
    widgets.add(mPullListView2);
    mPageController = PageController(initialPage: widget.type);
    mTabController = TabController(
        initialIndex: widget.type, length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    mTabController.dispose();
    mPageController.dispose();
  }

  _getquary(int type) {
    List mModelSearchs = new List();
    ModelSearch modelSearch = new ModelSearch();
    ListListBean mListBean = new ListListBean();
    mListBean.Value = '10';
    mListBean.Key = "BaseLogTypeID";
    mListBean.Contract = type == 1 ? '>=' : "<";
    mListBean.filedType = "Int";
    modelSearch.list.add(mListBean);
    mModelSearchs.add(modelSearch);
    Map<String, dynamic> other = {"queryInfo": json.encode(mModelSearchs)};
    return other;
  }

  _getquary2(List list) {
    List mModelSearchs = new List();
    ModelSearch modelSearch = new ModelSearch();
    ListListBean mListBean = new ListListBean();
    mListBean.Value = '10';
    mListBean.Key = "BaseLogTypeID";
    mListBean.Contract = widget.type == 0 ? '>=' : "<";
    mListBean.filedType = "Int";
    modelSearch.list.add(mListBean);
    mModelSearchs.add(modelSearch);
    mModelSearchs.addAll(list);
    Map<String, dynamic> other = {"queryInfo": json.encode(mModelSearchs)};
    if (widget.type == 0) {
      mPullListView1.other = other;
      mPullListView1.reLoad();
    } else {
      mPullListView2.other = other;
      mPullListView2.reLoad();
    }
  }

  @override
  void disMsg(int what, data) {
    switch (what) {
      case 888:
        List list = new List();
        list.addAll((json.decode(data.toString()) as List)
            .map((i) => ModelSearchGk.fromJson(i))
            .toList());
        _getquary2(list);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "日志统计",
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              size: ScreenUtil.getScaleW(context, 25),
            ),
            onPressed: () {
              print(widget.type.toString());
              List<SearchListBean> search = List();
              SearchListBean s1 = new SearchListBean();
              s1.type = "text";
              s1.text = "请输入人员、IP、内容";
              s1.sqlstring =
                  '{"isGroup":false,"list":[{"Key":"EmpName,BaseLogIP,BaseLogRefHTML","Contract":"like","Value":"#{value}"}]}';
              search.add(s1);
              Help.goWhere(context, PgSearch(widget.toString(), search));
            },
          ),
        ],
        centerTitle: true,
        bottom: TabBar(
          onTap: (i) => _changeTab(i),
          controller: mTabController,
          tabs: tabs,
          isScrollable: false,
          indicatorColor:
              Theme.of(context).accentColorBrightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
          unselectedLabelStyle: new TextStyle(fontSize: 16.0),
          labelStyle:
              new TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: PageView(
        controller: mPageController,
        onPageChanged: _changePage,
        children: widgets,
      ),
    );
  }

  void _changeTab(int i) {
    widget.type = i;
    mPageController.animateToPage(i,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void _changePage(int i) {
    widget.type = i;
    mTabController.animateTo(i,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  List _callBack(String methodName, res) {
    ModelRz mModelRz = ModelRz.fromJson(res.data);
    List data = new List();
    mModelRz.rows.forEach((item) {
      data.add(new ItemRz(item, widget.type));
    });
    return data;
  }
}

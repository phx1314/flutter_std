import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/item/ItemBase.dart';
import 'package:flutter_std/item/ItemFile.dart';
import 'package:flutter_std/item/ItemHt.dart';
import 'package:flutter_std/model/ModelFjList.dart';
import 'package:flutter_std/model/ModelFlowList.dart';
import 'package:flutter_std/model/ModelHt.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/PullListView.dart';

class PgHtList extends StatefulWidget {
  PgHtList();

  @override
  PgHtListState createState() => new PgHtListState();
}

class PgHtListState extends BaseState<PgHtList> {
  PullListView mPullListView;

  @override
  void initView() {
    mPullListView = PullListView(
      methodName: method_Contract,
      loadMoreEnable: false,
      mCallback: (methodName, res) {
        ModelHt mModelFlowList = ModelHt.fromJson(res.data);
        List data = new List();
        mModelFlowList.rows.forEach((f) {
          data.add(ItemHt(f));
        });
        return data;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('合同列表'),
        centerTitle: true,
      ),
      body: mPullListView,
    );
  }
}

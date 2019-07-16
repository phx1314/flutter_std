import 'package:flutter/material.dart';
import 'package:flutter_std/az/az_listview.dart';
import 'package:flutter_std/item/ItemSus.dart';
import 'package:flutter_std/item/ItemTxl.dart';
import 'package:flutter_std/model/ModelAz.dart';
import 'package:flutter_std/utils/BaseState.dart';

class PgAzList extends StatefulWidget {
  ModelAz data;
  int type;

  PgAzList(this.data, this.type);

  @override
  PgAzListState createState() => new PgAzListState();
}

class PgAzListState extends BaseState<PgAzList> {
  String suspensionTag;

  @override
  void initView() {
    suspensionTag = widget.data.suspensionTag;
  }

  @override
  Widget build(BuildContext context) {
    print('走了没');

    return AzListView(
      data: widget.data.data,
      isUseRealIndex: false,
      itemBuilder: (context, model) => ItemTxl(model, widget.type),
      suspensionWidget: ItemSus(suspensionTag),
      itemHeight: 80,
      suspensionHeight: 40,
      onSusTagChanged: _onSusTagChanged,
      //showCenterTip: false,
    );
  }

  void _onSusTagChanged(String tag) {
    suspensionTag= tag;
    reLoad();
  }
}

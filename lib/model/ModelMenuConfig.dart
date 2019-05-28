import 'package:flutter_std/model/ModelDx.dart';

class ModelMenuConfig {
  FlowBean flow;
  GridBean grid;
  List<SearchListBean> search;
  List<UploadersListBean> uploaders;

  ModelMenuConfig({this.flow, this.grid, this.search, this.uploaders});

  ModelMenuConfig.fromJson(Map<String, dynamic> json) {
    this.flow = FlowBean.fromJson(json['flow']);
    this.grid = GridBean.fromJson(json['grid']);
    this.search = (json['search'] as List) != null
        ? (json['search'] as List)
        .map((i) => SearchListBean.fromJson(i))
        .toList()
        : null;
    this.uploaders = (json['uploaders'] as List) != null
        ? (json['uploaders'] as List)
        .map((i) => UploadersListBean.fromJson(i))
        .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flow'] = this.flow.toJson();
    data['grid'] = this.grid.toJson();
    data['search'] = this.search != null
        ? this.search.map((i) => i.toJson()).toList()
        : null;
    data['uploaders'] = this.uploaders != null
        ? this.uploaders.map((i) => i.toJson()).toList()
        : null;
    return data;
  }
}

class FlowBean {
  String processor;
  String refTable;
  bool isShowSave;

  FlowBean({this.processor, this.refTable, this.isShowSave});

  FlowBean.fromJson(Map<String, dynamic> json) {
    this.processor = json['processor'];
    this.refTable = json['refTable'];
    this.isShowSave = json['isShowSave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['processor'] = this.processor;
    data['refTable'] = this.refTable;
    data['isShowSave'] = this.isShowSave;
    return data;
  }
}

class GridBean {
  String addUrl;
  String editUrl;
  String delUrl;
  String listPage;
  int rows;
  List<String> url;
  List queryParams;

  GridBean({this.addUrl,
    this.editUrl,
    this.delUrl,
    this.listPage,
    this.rows,
    this.queryParams,
    this.url});

  GridBean.fromJson(Map<String, dynamic> json) {
    this.addUrl = json['addUrl'];
    this.editUrl = json['editUrl'];
    this.delUrl = json['delUrl'];
    this.listPage = json['listPage'];
    this.rows = json['rows'];
    this.queryParams = (json['queryParams'] as List) != null
        ? (json['queryParams'] as List)
        : null;

    List<dynamic> urlList = json['url'];
    this.url = new List();
    this.url.addAll(urlList.map((o) => o.toString()));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addUrl'] = this.addUrl;
    data['editUrl'] = this.editUrl;
    data['delUrl'] = this.delUrl;
    data['listPage'] = this.listPage;
    data['rows'] = this.rows;
    data['queryParams'] = this.queryParams != null
        ? this.queryParams.map((i) => i.toJson()).toList()
        : null;
    data['url'] = this.url;
    return data;
  }
}

class SearchListBean {
  String type;
  String baseorder;
  String text;
  String multiselect;
  String sqlstring;
  String value;

  String ids;
  List<ModelDx> mModelDxs;

  SearchListBean(
      {this.type, this.baseorder, this.text, this.multiselect, this.sqlstring, this.value = ''});

  SearchListBean.fromJson(Map<String, dynamic> json) {
    this.type = json['type'];
    this.baseorder = json['baseorder'];
    this.text = json['text'];
    this.multiselect = json['multiselect'];
    this.sqlstring = json['sqlstring'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['baseorder'] = this.baseorder;
    data['text'] = this.text;
    data['multiselect'] = this.multiselect;
    data['sqlstring'] = this.sqlstring;
    return data;
  }
}

class UploadersListBean {
  String uploaderName;
  String refTable;

  UploadersListBean({this.uploaderName, this.refTable});

  UploadersListBean.fromJson(Map<String, dynamic> json) {
    this.uploaderName = json['uploaderName'];
    this.refTable = json['refTable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uploaderName'] = this.uploaderName;
    data['refTable'] = this.refTable;
    return data;
  }
}

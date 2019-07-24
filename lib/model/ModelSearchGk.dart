class ModelSearchGk {
  bool isGroup;
  List<ListBean> list;

  ModelSearchGk({this.isGroup, this.list});

  ModelSearchGk.fromJson(Map<String, dynamic> json) {    
    this.isGroup = json['isGroup'];
    this.list = (json['list'] as List)!=null?(json['list'] as List).map((i) => ListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isGroup'] = this.isGroup;
    data['list'] = this.list != null?this.list.map((i) => i.toJson()).toList():null;
    return data;
  }

}

class ListBean {
  String Key;
  String Contract;
  String Value;

  ListBean({this.Key, this.Contract, this.Value});

  ListBean.fromJson(Map<String, dynamic> json) {
    this.Key = json['Key'];
    this.Contract = json['Contract'];
    this.Value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Key'] = this.Key;
    data['Contract'] = this.Contract;
    data['Value'] = this.Value;
    return data;
  }
}

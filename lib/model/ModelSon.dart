class ModelSon {
  String nextOpenid;
  int total;
  int count;
  DataBean data;

  ModelSon({this.nextOpenid, this.total, this.count, this.data});

  ModelSon.fromJson(Map<String, dynamic> json) {    
    this.nextOpenid = json['next_openid'];
    this.total = json['total'];
    this.count = json['count'];
    this.data = DataBean.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next_openid'] = this.nextOpenid;
    data['total'] = this.total;
    data['count'] = this.count;
    data['data'] = this.data.toJson();
    return data;
  }

}

class DataBean {
  List<String> openid;

  DataBean({this.openid});

  DataBean.fromJson(Map<String, dynamic> json) {    

    List<dynamic> openidList = json['openid'];
    this.openid = new List();
    this.openid.addAll(openidList.map((o) => o.toString()));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['openid'] = this.openid;
    return data;
  }
}

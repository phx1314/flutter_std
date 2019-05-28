class ModelFjList {
  int total;
  List<RowsListBean> rows;

  ModelFjList({this.total, this.rows});

  ModelFjList.fromJson(Map<String, dynamic> json) {
    this.total = json['total'];
    this.rows = (json['rows'] as List) != null
        ? (json['rows'] as List).map((i) => RowsListBean.fromJson(i)).toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['rows'] =
        this.rows != null ? this.rows.map((i) => i.toJson()).toList() : null;
    return data;
  }
}

class RowsListBean {
  String Name;
  String LastModifyDate;
  String UploadDate;
  String EmpName;
  String Type;
  String Dir;
  String IDD;
  int ID;
  int Size;
  int Version;

  int AttachID;

  RowsListBean(
      {this.Name,
      this.LastModifyDate,
      this.UploadDate,
      this.EmpName,
      this.Type,
      this.Dir,
      this.ID,
      this.AttachID,
      this.Size,
      this.Version});

  RowsListBean.fromJson(Map<String, dynamic> json) {
    this.Name = json['Name'];
    this.AttachID = json['AttachID'];
    this.LastModifyDate = json['LastModifyDate'];
    this.UploadDate = json['UploadDate'];
    this.EmpName = json['EmpName'];
    this.Type = json['Type'];
    this.Dir = json['Dir'];
    this.ID = json['ID'];
    this.Size = json['Size'];
    this.Version = json['Version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.Name;
    data['AttachID'] = this.AttachID;
    data['LastModifyDate'] = this.LastModifyDate;
    data['UploadDate'] = this.UploadDate;
    data['EmpName'] = this.EmpName;
    data['Type'] = this.Type;
    data['Dir'] = this.Dir;
    data['ID'] = this.ID;
    data['Size'] = this.Size;
    data['Version'] = this.Version;
    return data;
  }
}

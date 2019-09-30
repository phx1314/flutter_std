class ModelAccessToken {
  String accessToken;
  int expiresIn;

  ModelAccessToken({this.accessToken, this.expiresIn});

  ModelAccessToken.fromJson(Map<String, dynamic> json) {
    this.accessToken = json['access_token'];
    this.expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['expires_in'] = this.expiresIn;
    return data;
  }
}

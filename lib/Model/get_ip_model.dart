/// ip : "42.111.224.186"

class GetIpModel {
  GetIpModel({
      this.ip,});

  GetIpModel.fromJson(dynamic json) {
    ip = json['ip'];
  }
  String? ip;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ip'] = ip;
    return map;
  }

}
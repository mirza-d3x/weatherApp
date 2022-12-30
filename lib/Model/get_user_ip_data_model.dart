/// ip : "42.111.224.186"
/// hostname : "42-111-224-186.live.vodafone.in"
/// city : "Kozhikode"
/// region : "Kerala"
/// country : "IN"
/// loc : "11.2480,75.7804"
/// org : "AS38266 Vodafone India Ltd."
/// postal : "673004"
/// timezone : "Asia/Kolkata"
/// readme : "https://ipinfo.io/missingauth"

class GetUserIpDataModel {
  GetUserIpDataModel({
      this.ip, 
      this.hostname, 
      this.city, 
      this.region, 
      this.country, 
      this.loc, 
      this.org, 
      this.postal, 
      this.timezone, 
      this.readme,});

  GetUserIpDataModel.fromJson(dynamic json) {
    ip = json['ip'];
    hostname = json['hostname'];
    city = json['city'];
    region = json['region'];
    country = json['country'];
    loc = json['loc'];
    org = json['org'];
    postal = json['postal'];
    timezone = json['timezone'];
    readme = json['readme'];
  }
  String? ip;
  String? hostname;
  String? city;
  String? region;
  String? country;
  String? loc;
  String? org;
  String? postal;
  String? timezone;
  String? readme;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ip'] = ip;
    map['hostname'] = hostname;
    map['city'] = city;
    map['region'] = region;
    map['country'] = country;
    map['loc'] = loc;
    map['org'] = org;
    map['postal'] = postal;
    map['timezone'] = timezone;
    map['readme'] = readme;
    return map;
  }

}
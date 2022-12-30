import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather_lilac/Model/get_ip_model.dart';

import '../../Model/get_user_ip_data_model.dart';
import '../../Model/get_weather_data_model.dart';

class Apis {
  Future<GetWeatherDataModel> getWeatherData({required String city}) async {
    Response response = await get(
        Uri.parse(
            'https://api.weatherapi.com/v1/current.json?key=c0dbb6f1794640eeabf103014222805&q=$city&aqi=no'),
        headers: {});
    return GetWeatherDataModel.fromJson(jsonDecode(response.body));
  }

  Future<GetIpModel> getIpAddress() async {
    Response response =
        await get(Uri.parse('https://api.ipify.org/?format=json'), headers: {});
    return GetIpModel.fromJson(jsonDecode(response.body));
  }

  Future<GetUserIpDataModel> getDataFromIp({required String ip}) async {
    Response response =
        await get(Uri.parse('https://ipinfo.io/$ip/geo'), headers: {});
    return GetUserIpDataModel.fromJson(jsonDecode(response.body));
  }
}

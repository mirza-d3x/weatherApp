import 'dart:convert';
import 'package:http/http.dart';
import 'package:weather_lilac/Model/get_ip_model.dart';
import '../../Model/get_user_ip_data_model.dart';
import '../../Model/get_weather_data_model.dart';
import 'api_client.dart';

class Apis {
  ApiClient apiClient = ApiClient();
  Future<GetWeatherDataModel> getWeatherData({required String city}) async {
    Response response = await apiClient.invokeAPI(path: '$city&aqi=no', method: 'GET', body: null);
    // print(response.body);
    // print(response.statusCode);
    return GetWeatherDataModel.fromJson(jsonDecode(response.body));
  }

  Future<GetIpModel> getIpAddress() async {
    Response response =
        await get(Uri.parse('https://api.ipify.org/?format=json'), headers: {});
    // print(response.body);
    return GetIpModel.fromJson(jsonDecode(response.body));
  }

  Future<GetUserIpDataModel> getDataFromIp({required String ip}) async {
    Response response =
        await get(Uri.parse('https://ipinfo.io/$ip/geo'), headers: {});
    // print(response.body);
    return GetUserIpDataModel.fromJson(jsonDecode(response.body));
  }
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_lilac/Model/get_ip_model.dart';

import '../../../Infrastructure/Api/api_functions.dart';
import '../../../Model/get_user_ip_data_model.dart';
import '../../../Model/get_weather_data_model.dart';

part 'api_data_event.dart';

part 'api_data_state.dart';

class ApiDataBloc extends Bloc<ApiDataEvent, ApiDataState> {
  late GetWeatherDataModel getWeatherDataModel;
  late GetIpModel getUserIp;
  late GetUserIpDataModel getUserIpDataModel;
  Apis apis;

  ApiDataBloc(this.apis) : super(ApiDataInitial()) {
    on<GetUserIpEvent>((event, emit) async {
      emit(IpAddressLoading());
      try {
        getUserIp = await apis.getIpAddress();
        emit(IpAddressLoaded());
      } catch (e) {
        emit(IpAddressFailed());
      }
    });

    on<GetUserDataFromIpEvent>((event, emit) async {
      emit(UserDataLoading());
      try {
        getUserIpDataModel = await apis.getDataFromIp(ip: event.ip);
        emit(UserDataLoaded());
      } catch (e) {
        emit(IpAddressFailed());
      }
    });

    on<GetWeatherDataEvent>((event, emit) async {
      emit(UserDataLoading());
      try {
        getWeatherDataModel = await apis.getWeatherData(city: event.city);
        emit(WeatherDataLoaded());
      } catch (e) {
        emit(IpAddressFailed());
      }
    });
  }
}

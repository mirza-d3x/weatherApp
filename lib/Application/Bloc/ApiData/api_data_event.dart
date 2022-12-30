part of 'api_data_bloc.dart';

@immutable
abstract class ApiDataEvent {}

class GetUserIpEvent extends ApiDataEvent {}

class GetUserDataFromIpEvent extends ApiDataEvent {
  final String ip;

  GetUserDataFromIpEvent({required this.ip});
}

class GetWeatherDataEvent extends ApiDataEvent {
  final String city;

  GetWeatherDataEvent({required this.city});
}

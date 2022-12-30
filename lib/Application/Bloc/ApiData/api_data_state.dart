part of 'api_data_bloc.dart';

@immutable
abstract class ApiDataState {}

class ApiDataInitial extends ApiDataState {}

class WeatherDataLoading extends ApiDataState {}

class WeatherDataLoaded extends ApiDataState {}

class WeatherDataFailed extends ApiDataState {}

class IpAddressLoading extends ApiDataState {}

class IpAddressLoaded extends ApiDataState {}

class IpAddressFailed extends ApiDataState {}

class UserDataLoading extends ApiDataState {}

class UserDataLoaded extends ApiDataState {}

class UserDataFailed extends ApiDataState {}

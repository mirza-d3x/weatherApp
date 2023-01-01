part of 'weather_db_bloc.dart';

@immutable
abstract class WeatherDbState {}

class WeatherDbInitial extends WeatherDbState {}

class DataSavingOnDb extends WeatherDbState {}

class DataSaved extends WeatherDbState {}

class DataSavingFailed extends WeatherDbState {}

class DataLoading extends WeatherDbState {}

class DataLoaded extends WeatherDbState {}

class DateFailed extends WeatherDbState {}

class SearchDataLoaded extends WeatherDbState {}

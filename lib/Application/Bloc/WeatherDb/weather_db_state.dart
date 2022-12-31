part of 'weather_db_bloc.dart';

@immutable
abstract class WeatherDbState {}

class WeatherDbInitial extends WeatherDbState {}

class SaveWeatherData extends WeatherDbState {}

class GetWeatherData extends WeatherDbState {}

class DataSavingOnDb extends WeatherDbState {}

class DataSaved extends WeatherDbState {}

class DataSavingFailed extends WeatherDbState {}

part of 'weather_db_bloc.dart';

@immutable
abstract class WeatherDbEvent {}

class SaveWeatherDataInDbEvent extends WeatherDbEvent {
  final GetWeatherDataModel getWeatherDataModel;

  SaveWeatherDataInDbEvent({required this.getWeatherDataModel});
}

class GetWeatherDataFromDbEvent extends WeatherDbEvent {}

class SearchWeatherData extends WeatherDbEvent {
  final String query;

  SearchWeatherData(this.query);
}

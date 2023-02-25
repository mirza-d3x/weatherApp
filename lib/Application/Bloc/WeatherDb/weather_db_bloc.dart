import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:weather_lilac/Model/get_weather_data_model.dart';

part 'weather_db_event.dart';

part 'weather_db_state.dart';

class WeatherDbBloc extends Bloc<WeatherDbEvent, WeatherDbState> {
  late GetWeatherDataModel getWeatherDataModel;
  late Current currentModel;
  List searchResults = [];

  WeatherDbBloc() : super(WeatherDbInitial()) {
    on<SaveWeatherDataInDbEvent>((event, emit) async {
      emit(DataSavingOnDb());
      var weatherBox = await Hive.openBox<Object>('weather');
      try {
        if (weatherBox.isEmpty) {
          weatherBox.add(jsonEncode(event.getWeatherDataModel.toJson()));
        } else if(weatherBox.isNotEmpty) {
          weatherBox.putAt(0, jsonEncode(event.getWeatherDataModel.toJson()));
        }
        emit(DataSaved());
      } catch (e) {
        log(e.toString());
        emit(DataSavingFailed());
      }
    });

    on<GetWeatherDataFromDbEvent>((event, emit) async {
      emit(DataLoading());
      var weatherBox = await Hive.openBox<Object>('weather');
      try {
        getWeatherDataModel = GetWeatherDataModel.fromJson(
            jsonDecode(weatherBox.values.first.toString()));
        emit(DataLoaded());
      } catch (e) {
        log(e.toString());
        emit(DateFailed());
      }
    });

    on<SearchWeatherData>((event, emit) async {
      emit(DataLoading());
      var weatherBox = await Hive.openBox<Object>('weather');
      try {
        getWeatherDataModel = GetWeatherDataModel.fromJson(
            jsonDecode(weatherBox.values.first.toString()));
        // searchResults.addAll()
        print(weatherBox.values.first);
        print('=================================================================');
        print('=================================================================');
        print('=================================================================');
        print(weatherBox.values.map((e) => e == event.query));
        print(getWeatherDataModel.current!.toJson().containsKey(event.query));
        print(getWeatherDataModel.current!.toJson().keys.where((element) => element.contains(event.query)).toString());
        searchResults = getWeatherDataModel.current!.toJson().keys.where((element) => element.contains(event.query)).toList();
        print(searchResults);
        emit(SearchDataLoaded());
      } catch (e) {
        log(e.toString());
        emit(DateFailed());
      }
    });
  }
}

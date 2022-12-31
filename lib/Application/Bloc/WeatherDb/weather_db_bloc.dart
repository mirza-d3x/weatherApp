import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:weather_lilac/Model/get_weather_data_model.dart';

part 'weather_db_event.dart';

part 'weather_db_state.dart';

class WeatherDbBloc extends Bloc<WeatherDbEvent, WeatherDbState> {
  late GetWeatherDataModel getWeatherDataModel;

  WeatherDbBloc() : super(WeatherDbInitial()) {
    on<SaveWeatherDataInDbEvent>((event, emit) async {
      var weatherBox = await Hive.openBox<GetWeatherDataModel>('weather');
      print('HiveBloc==============================================');
      emit(DataSavingOnDb());
      try {
        weatherBox.add(event.getWeatherDataModel);
        emit(DataSaved());
      } catch (e) {
        print('$e============================================');
        emit(DataSavingFailed());
      }
    });

    on<GetWeatherDataFromDbEvent>((event, emit) {});
  }
}

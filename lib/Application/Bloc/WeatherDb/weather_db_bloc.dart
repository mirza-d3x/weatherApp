import 'dart:async';
import 'dart:convert';

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
      var weatherBox = await Hive.openBox<Object>('weather');
      print('HiveBloc==============================================');
      emit(DataSavingOnDb());
      try {
        if(weatherBox.isEmpty){
          weatherBox.add(event.getWeatherDataModel.toJson());
        }

        // weatherBox.clear();
        // weatherBox.close();
        emit(DataSaved());
      } catch (e) {
        print('$e============================================');
        emit(DataSavingFailed());
      }
    });

    on<GetWeatherDataFromDbEvent>((event, emit) async {
      var weatherBox = await Hive.openBox<Object>('weather');
      emit(DataLoading());
      try {
        // print(weatherBox.values.single.);
        print('==Before======================================');

print(jsonEncode(weatherBox.values.first.toString().split('(').last.split(')').first));
print(weatherBox.values.toString().split('gust_kph').last.split(')').first);
print(jsonDecode(jsonDecode(weatherBox.values.first.toString())));
        print('========================================');
        print('========Before Model================================');
        // getWeatherDataModel= getWeatherDataModelFromJson(weatherBox.values.first.toString());
     // getWeatherDataModel = GetWeatherDataModel.fromJson(jsonDecode(jsonEncode(weatherBox.values.first.toString().split('(').last.split(')').first)));
     getWeatherDataModel = GetWeatherDataModel.fromJson(jsonDecode(jsonDecode(jsonEncode(weatherBox.values.first.toString()))));
        print('========After Model================================');
      // getWeatherDataModel =  GetWeatherDataModel.fromJson(jsonDecode(weatherBox.values.toString()));
      // getWeatherDataModel =  weatherBox.values.single;
        // getWeatherDataModel = weatherBox.values;
        emit(DataLoaded());
      } catch (e) {
        print(e.toString() + '------------------------------------------------------------------');
        emit(DateFailed());
      }
    });
  }
}

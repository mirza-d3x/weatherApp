import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_lilac/Application/Bloc/WeatherDb/weather_db_bloc.dart';
import 'package:weather_lilac/Infrastructure/Api/api_functions.dart';
import 'package:weather_lilac/Model/get_weather_data_model.dart';
import 'Application/Bloc/ApiData/api_data_bloc.dart';
import 'Presentation/SplashScreen/splash_screen.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';

void main() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(GetWeatherDataModelAdapter().typeId)) {
    Hive.registerAdapter(GetWeatherDataModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Apis apis = Apis();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ApiDataBloc(apis),
        ),
        BlocProvider(
          create: (context) => WeatherDbBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ScreeSplash(),
      ),
    );
  }
}

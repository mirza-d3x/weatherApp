import 'package:flutter/material.dart';
import 'package:weather_lilac/Infrastructure/Api/api_functions.dart';
import 'Application/Bloc/ApiData/api_data_bloc.dart';
import 'Presentation/SplashScreen/splash_screen.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Apis apis = Apis();
    return BlocProvider(
      create: (context) => ApiDataBloc(apis),
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

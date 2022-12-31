import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_lilac/Application/Bloc/ApiData/api_data_bloc.dart';
import 'package:weather_lilac/Application/Bloc/WeatherDb/weather_db_bloc.dart';
import 'package:weather_lilac/Model/get_ip_model.dart';
import 'package:weather_lilac/Model/get_user_ip_data_model.dart';
import 'package:weather_lilac/Model/get_weather_data_model.dart';
import 'package:weather_lilac/Presentation/Dashboard/dashboard_screen.dart';

class ScreeSplash extends StatefulWidget {
  const ScreeSplash({Key? key}) : super(key: key);

  @override
  State<ScreeSplash> createState() => _ScreeSplashState();
}

class _ScreeSplashState extends State<ScreeSplash> {
  @override
  void initState()  {
    checkData();
    super.initState();
  }

  checkData() async {
    var weatherBox = await Hive.openBox<GetWeatherDataModel>('weather');

    if (weatherBox.values.isNotEmpty) {
      Future.delayed(
        const Duration(seconds: 3),
        () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => ScreenDashBoard(),
              ),
              (route) => false);
        },
      );
      await weatherBox.close();
    } else {
      await Hive.deleteFromDisk();
      await Hive.deleteBoxFromDisk('weather');
      BlocProvider.of<ApiDataBloc>(context).add(GetUserIpEvent());
    }
  }

  late GetIpModel getIpModel;
  late GetUserIpDataModel getUserIpDataModel;
  late GetWeatherDataModel getWeatherDataModel;

  // var weatherBox = Hive.box<GetWeatherDataModel>('weather');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: MultiBlocListener(
        listeners: [
          BlocListener<ApiDataBloc, ApiDataState>(
            listener: (context, state) {
              print(state);
              if (state is IpAddressLoaded) {
                getIpModel = BlocProvider.of<ApiDataBloc>(context).getUserIp;
                BlocProvider.of<ApiDataBloc>(context)
                    .add(GetUserDataFromIpEvent(ip: getIpModel.ip!));
              }
              if (state is UserDataLoaded) {
                getUserIpDataModel =
                    BlocProvider.of<ApiDataBloc>(context).getUserIpDataModel;
                BlocProvider.of<ApiDataBloc>(context)
                    .add(GetWeatherDataEvent(city: getUserIpDataModel.city!));
              }
              if (state is WeatherDataLoaded) {
                getWeatherDataModel =
                    BlocProvider.of<ApiDataBloc>(context).getWeatherDataModel;
                print('Hive =====================================');
                BlocProvider.of<WeatherDbBloc>(context).add(
                    SaveWeatherDataInDbEvent(
                        getWeatherDataModel: getWeatherDataModel));
              }
            },
          ),
          BlocListener<WeatherDbBloc, WeatherDbState>(
            listener: (context, state) {
              print(state);
              if (state is DataSaved) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => ScreenDashBoard(),
                    ),
                    (route) => false);
              }
            },
          ),
        ],
        child: const Center(
          child: Text(
            'Lilac Flutter Assignment',
            style: TextStyle(fontSize: 26, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

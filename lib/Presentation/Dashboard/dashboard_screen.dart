import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_lilac/Application/Bloc/WeatherDb/weather_db_bloc.dart';

import '../../Model/get_weather_data_model.dart';

class ScreenDashBoard extends StatefulWidget {
  ScreenDashBoard({Key? key}) : super(key: key);

  @override
  State<ScreenDashBoard> createState() => _ScreenDashBoardState();
}

class _ScreenDashBoardState extends State<ScreenDashBoard> {
  // DataModel? weatherData;
  // String timeNow = DateFormat("hh:mm: a").format(DateTime.now());
  // String cityName = "Malappuram";

  @override
  void initState() {
    BlocProvider.of<WeatherDbBloc>(context)
        .add(GetWeatherDataFromDbEvent());
    super.initState();
  }

  late GetWeatherDataModel getWeatherDataModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<WeatherDbBloc, WeatherDbState>(
          builder: (context, state) {
            if (state is DataLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is DataLoaded) {
              getWeatherDataModel =
                  BlocProvider.of<WeatherDbBloc>(context).getWeatherDataModel;
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration:  BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://media.istockphoto.com/id/1271638274/vector/beautiful-night-landscape-illustration.jpg?s=612x612&w=0&k=20&c=J78Vz1DQqunoEj1bpo_SbnXQNMy4kNZQLIYi9G473as="),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         Text(
                           // getWeatherDataModel.current!.tempC.toString(),
                           's0',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 80,
                          ),
                        ),
                         Padding(
                          padding: EdgeInsets.only(bottom: 60, left: 10),
                          child: Text(
                            "o",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Column(
                          children: [
                             Text(
                              "dsghjfglnatuave",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 60,
                              ),
                            ),
                             Text(
                              "shghhagnj",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 60,
                              ),
                            ),
                          ],
                        ),
                         Text(
                          "jaghajdg",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 80,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            BlocProvider.of<WeatherDbBloc>(context)
                .add(GetWeatherDataFromDbEvent());
          },
          child:  Icon(Icons.arrow_upward),
        ),
      ),
    );
  }
}

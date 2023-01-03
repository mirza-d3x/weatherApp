import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:weather_lilac/Application/Bloc/ApiData/api_data_bloc.dart';
import 'package:weather_lilac/Application/Bloc/WeatherDb/weather_db_bloc.dart';
import 'package:weather_lilac/Model/get_user_ip_data_model.dart';
import 'package:weather_lilac/Presentation/SearchPage/search_screen.dart';

import '../../Model/get_ip_model.dart';
import '../../Model/get_weather_data_model.dart';

class ScreenDashBoard extends StatefulWidget {
  const ScreenDashBoard({Key? key}) : super(key: key);

  @override
  State<ScreenDashBoard> createState() => _ScreenDashBoardState();
}

class _ScreenDashBoardState extends State<ScreenDashBoard> {
  @override
  void initState() {
    BlocProvider.of<WeatherDbBloc>(context).add(GetWeatherDataFromDbEvent());
    super.initState();
  }

  List icon = [
    "assets/rainy_2d.png",
    "assets/thunder_2d.png",
    "assets/rainy_2d.png",
    "assets/snow_2d.png",
  ];
  late GetWeatherDataModel getWeatherDataModel;

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: MultiBlocListener(
        listeners: [
          BlocListener<ApiDataBloc, ApiDataState>(
            listener: (context, state) {
              if (state is IpAddressLoaded) {
                GetIpModel getIpModel =
                    BlocProvider.of<ApiDataBloc>(context).getUserIp;
                BlocProvider.of<ApiDataBloc>(context)
                    .add(GetUserDataFromIpEvent(ip: getIpModel.ip!));
              }
              if (state is UserDataLoaded) {
                GetUserIpDataModel getUserIpDataModel =
                    BlocProvider.of<ApiDataBloc>(context).getUserIpDataModel;
                BlocProvider.of<ApiDataBloc>(context)
                    .add(GetWeatherDataEvent(city: getUserIpDataModel.city!));
              }
              if (state is WeatherDataLoaded) {
                GetWeatherDataModel getWeatherDataModels =
                    BlocProvider.of<ApiDataBloc>(context).getWeatherDataModel;
                BlocProvider.of<WeatherDbBloc>(context).add(
                    SaveWeatherDataInDbEvent(
                        getWeatherDataModel: getWeatherDataModels));
              }
            },
          ),
          BlocListener<WeatherDbBloc, WeatherDbState>(
            listener: (context, state) {
              if (state is DataSaved) {
                BlocProvider.of<WeatherDbBloc>(context)
                    .add(GetWeatherDataFromDbEvent());
              }
            },
          ),
        ],
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black,
          body: BlocBuilder<WeatherDbBloc, WeatherDbState>(
            builder: (context, state) {
              if (state is DataLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is DataLoaded) {
                getWeatherDataModel =
                    BlocProvider.of<WeatherDbBloc>(context).getWeatherDataModel;
                return SizedBox(
                  height: mHeight,
                  width: mWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GlowContainer(
                        height: mHeight - 220,
                        margin: const EdgeInsets.all(2),
                        padding:
                            const EdgeInsets.only(top: 5, left: 25, right: 25),
                        glowColor: const Color(0xff00A1FF).withOpacity(0.5),
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(60),
                            bottomRight: Radius.circular(60)),
                        color: const Color(0xff00A1FF),
                        spreadRadius: 5,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<ApiDataBloc>(context)
                                        .add(GetUserIpEvent());
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 1),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.2, color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: const Text(
                                      "Update",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(CupertinoIcons.map_fill,
                                        color: Colors.white),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      getWeatherDataModel.location!.name!,
                                      overflow: TextOverflow.fade,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: mHeight * .47,
                              child: Stack(
                                children: [
                                  
                                  const Image(
                                    image: AssetImage('assets/sunny.png'),
                                    fit: BoxFit.fill,
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    left: 0,
                                    child: Center(
                                      child: Column(
                                        children: [
                                          GlowText(
                                            getWeatherDataModel.current!.tempC!
                                                .toString()
                                                .split('.')
                                                .first,
                                            style: const TextStyle(
                                                height: 0.1,
                                                fontSize: 120,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            getWeatherDataModel
                                                .current!.condition!.text!,
                                            style: const TextStyle(
                                              fontSize: 25,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            getWeatherDataModel
                                                .location!.localtime
                                                .toString()
                                                .split(' ')
                                                .first,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            getWeatherDataModel
                                                .location!.localtime
                                                .toString()
                                                .split(' ')
                                                .last,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    const Icon(
                                      CupertinoIcons.wind,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${getWeatherDataModel.current!.windKph.toString().split('.').first} Km/h",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      "Wind",
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 16),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Icon(
                                      CupertinoIcons.wind,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${getWeatherDataModel.current!.humidity.toString()}%",
                                      // temp.humidity.toString() + " %",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      "Humidity",
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 16),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Icon(
                                      CupertinoIcons.wind,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      getWeatherDataModel.current!.cloud
                                          .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      "Cloud",
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 16),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Today",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Row(
                                  children: const [
                                    Text(
                                      "7 days ",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.grey),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: Colors.grey,
                                      size: 15,
                                    )
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.2, color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(35)),
                                    child: Column(
                                      children: [
                                        Text(
                                          "${getWeatherDataModel.current!.tempC!.toString().split('.').first}\u00B0",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Image(
                                          image: AssetImage(icon[0]),
                                          width: 50,
                                          height: 50,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          getWeatherDataModel
                                              .location!.localtime
                                              .toString()
                                              .split(' ')
                                              .last,
                                          style: const TextStyle(
                                              fontSize: 16, color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.2, color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(35)),
                                    child: Column(
                                      children: [
                                        Text(
                                          "${getWeatherDataModel.current!.tempC!.toString().split('.').first}\u00B0",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Image(
                                          image: AssetImage(icon[3]),
                                          width: 50,
                                          height: 50,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          getWeatherDataModel
                                              .location!.localtime
                                              .toString()
                                              .split(' ')
                                              .last,
                                          style: const TextStyle(
                                              fontSize: 16, color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.2, color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(35)),
                                    child: Column(
                                      children: [
                                        Text(
                                          "${getWeatherDataModel.current!.tempC!.toString().split('.').first}\u00B0",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Image(
                                          image: AssetImage(icon[1]),
                                          width: 50,
                                          height: 50,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          getWeatherDataModel
                                              .location!.localtime
                                              .toString()
                                              .split(' ')
                                              .last,
                                          style: const TextStyle(
                                              fontSize: 16, color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ScreenSearch()));
            },
            child: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}

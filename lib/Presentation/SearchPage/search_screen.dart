import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:weather_lilac/Application/Bloc/WeatherDb/weather_db_bloc.dart';
import 'package:weather_lilac/Model/get_weather_data_model.dart';

class ScreenSearch extends StatelessWidget {
  ScreenSearch({Key? key}) : super(key: key);
  late List<dynamic> searchResult;
  late GetWeatherDataModel getWeatherDataModel;

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            GlowContainer(
              color: const Color(0xff00A1FF),
              glowColor: const Color(0xff00A1FF),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60)),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, right: 30, left: 30, bottom: 5),
                child: Container(
                  margin: EdgeInsets.only(top: mHeight * .0),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: mHeight * .098,
                  width: mWidth,
                  decoration: const BoxDecoration(
                    color: Color(0xff00A1FF),
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10),
                      right: Radius.circular(10),
                    ),
                  ),
                  child: SizedBox(
                    height: mHeight * .05,
                    width: mWidth,
                    child: TextFormField(
                      onChanged: (query) {
                        BlocProvider.of<WeatherDbBloc>(context)
                            .add(SearchWeatherData(query));
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(Icons.search),
                        hintText: "Search Here...",
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(70),
                            right: Radius.circular(70),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            BlocBuilder<WeatherDbBloc, WeatherDbState>(
              builder: (context, state) {
                if (state is SearchDataLoaded) {
                  searchResult =
                      BlocProvider.of<WeatherDbBloc>(context).searchResults;
                  getWeatherDataModel = BlocProvider.of<WeatherDbBloc>(context)
                      .getWeatherDataModel;
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                        itemCount: searchResult.length,
                        itemBuilder: (BuildContext context, int index) =>
                            GlowContainer(
                          height: mHeight * .1,
                          width: mWidth,
                          margin: const EdgeInsets.only(
                            bottom: 15,
                          ),
                              color: const Color(0xff00A1FF),
                              glowColor: const Color(0xff00A1FF),
                          borderRadius: BorderRadius.circular(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                searchResult[index],
                                style: const TextStyle(
                                  fontSize: 26,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                getWeatherDataModel.current!
                                    .toJson()[searchResult[index]]
                                    .toString(),
                                style: const TextStyle(
                                  fontSize: 26,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

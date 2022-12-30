import 'package:flutter/material.dart';

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
    // fetchWeather(cityName);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
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
                  const Text(
                    "sjhgjlsnhgus",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 80,
                    ),
                  ),
                  const Padding(
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
                      const Text(
                        "dsghjfglnatuave",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 60,
                        ),
                      ),
                      const Text(
                        "shghhagnj",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 60,
                        ),
                      ),
                    ],
                  ),
                  const Text(
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
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  color: Colors.deepPurple,
                  height: MediaQuery.of(context).size.height / .20,
                  child: Padding(
                    padding: const EdgeInsets.all(80),
                    child: Column(
                      children: [
                        TextField(
                          onSubmitted: (value) {
                            //   setState(() {
                            //     cityName = value;
                            //   });
                            //   fetchWeather(value);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: const Icon(Icons.arrow_upward),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:weather_lilac/Presentation/Dashboard/dashboard_screen.dart';

class ScreeSplash extends StatefulWidget {
  const ScreeSplash({Key? key}) : super(key: key);

  @override
  State<ScreeSplash> createState() => _ScreeSplashState();
}

class _ScreeSplashState extends State<ScreeSplash> {
  @override
  void initState() {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Text(
          'Lilac Flutter Assignment',
          style: TextStyle(fontSize: 26, color: Colors.white),
        ),
      ),
    );
  }
}

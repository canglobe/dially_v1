import 'dart:async';

import 'package:diali/screens/home/homepage.dart';
import 'package:flutter/cupertino.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (c) => HomeScreen()),
            (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Center(
            child: SizedBox(
                height: 150,
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(9),
                    ),
                    child: Image.asset('assets/app_store_icon.png')))));
  }
}

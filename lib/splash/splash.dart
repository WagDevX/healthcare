import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthcare/pages/welcome_page.dart';
import 'package:healthcare/router/router.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  startTimer() {
    var duration = const Duration(milliseconds: 4400);
    return Timer(duration, route);
  }

  route() {
    Navigator.of(context)
        .pushReplacement(Routering.createRoute(const WelcomePage()));
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: content(),
    );
  }

  Widget content() {
    return Center(
      child: Container(
        child: Lottie.asset('lib/assets/lotties/loader.json'),
      ),
    );
  }
}

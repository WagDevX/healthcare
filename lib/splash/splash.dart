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
    Navigator.of(context).pushReplacement(Routering.createRoute(WelcomePage()));
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

  // Route createRoute() {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) =>
  //         const WelcomePage(),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       const begin = Offset(1.0, 0.0);
  //       const end = Offset.zero;
  //       const curve = Curves.ease;

  //       var tween =
  //           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  //       return SlideTransition(
  //         position: animation.drive(tween),
  //         child: child,
  //       );
  //     },
  //   );
  // }

  Widget content() {
    return Center(
      child: Container(
        child: Lottie.asset('lib/assets/lotties/loader.json'),
      ),
    );
  }
}

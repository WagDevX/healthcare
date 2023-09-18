import 'package:flutter/material.dart';
import 'package:healthcare/pages/calculardora_imc_page.dart';
import 'package:healthcare/splash/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    precacheImage(
        const AssetImage('lib/assets/images/backgroundv_2.jpg'), context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const Splash(),
        '/calculadora': (context) => const CalculadoraImcPage(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:healthcare/pages/calculardora_imc_page.dart';
import 'package:healthcare/router/router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottomOpacity: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: Color.fromRGBO(77, 145, 255, 0.3),
              borderRadius: BorderRadius.all(Radius.circular(100))),
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(77, 145, 255, 0.4),
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
            child: Image.asset(
              "lib/assets/images/_logo.png",
              height: 150,
              color: Colors.white,
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
              image: DecorationImage(
                  image: AssetImage('lib/assets/images/backgroundv_2.jpg'),
                  fit: BoxFit.fitWidth)),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(40))),
        backgroundColor: Colors.lightBlue,
        toolbarHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(children: [
              const Text(
                "Seja bem vindo ao \napp Health Care!",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                    color: Colors.blueAccent),
              ),
              Container(
                padding: const EdgeInsets.all(7),
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(60))),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    color: Colors.blue,
                    borderRadius: const BorderRadius.all(Radius.circular(60)),
                  ),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            Routering.createRoute(const CalculadoraImcPage()));
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )),
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:healthcare/pages/calculardora_imc_page.dart';
import 'package:healthcare/router/router.dart';
import 'package:blurrycontainer/blurrycontainer.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/assets/images/backgroundv_2.jpg'),
                fit: BoxFit.fitWidth)),
        child: SizedBox(
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Expanded(
              flex: 4,
              child: Image.asset(
                "lib/assets/images/_logo.png",
                height: 200,
                color: Colors.blue,
              ),
            ),
            const Expanded(
                flex: 2,
                child: Text(
                  "Seja bem vindo ao app Health Care!",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.blueAccent),
                )),
            const Expanded(
              flex: 2,
              child: Text(
                "Vamos calcular o seu IMC?",
                style: TextStyle(fontSize: 16, color: Colors.blueAccent),
              ),
            ),
            Expanded(
                flex: 1,
                child: BlurryContainer(
                    blur: 4,
                    width: double.maxFinite,
                    elevation: 0,
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(2),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              Routering.createRoute(
                                  const CalculadoraImcPage()));
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Vamos lá!",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2196F3)),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.blue,
                            )
                          ],
                        ))))
          ]),
        ),
      ),
    );
  }
}

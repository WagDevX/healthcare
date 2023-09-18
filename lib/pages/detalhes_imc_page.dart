import 'package:flutter/material.dart';
import 'package:healthcare/models/pessoa.dart';

class DetalhesIMC extends StatelessWidget {
  final Pessoa pessoa;
  const DetalhesIMC({super.key, required this.pessoa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Olá ${pessoa.nome}!",
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                const Text(
                  "O resultado do seu IMC é:",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 30),
                Text(
                  pessoa.retornaResultadoIMC(),
                  style: const TextStyle(
                      fontSize: 36, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Confira algumas dicas para se manter saudável:",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                const ListTile(
                    leading: Icon(Icons.food_bank),
                    title: Text("Alimentação equilibrada"),
                    subtitle: Text(
                        "Consuma frutas, vegetais, proteínas magras e grãos integrais.")),
                const ListTile(
                  leading: Icon(Icons.skateboarding_rounded),
                  title: Text("Atividade física regular"),
                  subtitle:
                      Text("Exercite-se pelo menos 150 minutos por semana."),
                ),
                const ListTile(
                  leading: Icon(Icons.water_drop),
                  title: Text("Hidratação adequada"),
                  subtitle: Text("Beba água suficiente ao longo do dia."),
                ),
                const ListTile(
                  leading: Icon(Icons.bedtime),
                  title: Text("Sono de qualidade"),
                  subtitle: Text("Durma de 7 a 9 horas por noite."),
                ),
                const ListTile(
                  leading: Icon(Icons.thumb_up),
                  title: Text("Gerenciamento de estresse"),
                  subtitle:
                      Text("Pratique técnicas de relaxamento e mindfulness."),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

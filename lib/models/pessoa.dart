// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';

class Pessoa {
  final String _id = UniqueKey().toString();
  String _nome = "";
  double _peso = 0.0;
  double _altura = 0.0;

  String get id => _id;

  String get nome => _nome;

  double get peso => _peso;

  double get altura => _altura;

  set altura(double altura) => _altura = altura;

  set peso(double peso) => _peso = peso;

  set nome(String nome) => _nome = nome;

  Pessoa(String nome, double peso, double altura) {
    _altura = altura;
    _peso = peso;
    _nome = nome;
  }

  double retornaIMC() {
    if (_altura == 0) {
      throw ArgumentError("Altura não pode ser zero!");
    } else if (_peso == 0) {
      throw ArgumentError("Peso não pode ser zero!");
    }
    return _peso / (_altura * _altura);
  }

  String retornaResultadoIMC() {
    var imc = retornaIMC();
    switch (imc) {
      case < 16:
        return "Magreza grave!";
      case >= 16 && < 17:
        return "Magreza moderada!";
      case >= 17 && < 18.5:
        return "Magreza leve!";
      case >= 18.5 && < 25:
        return "Saudável!";
      case >= 25 && < 30:
        return "Sobrepeso!";
      case >= 30 && < 35:
        return "Obesidade Grau I!";
      case >= 35 && < 40:
        return "Obesidade Grau II!";
      case >= 40:
        return "Obesidade Grau III!";
      default:
        return "Erro";
    }
  }
}

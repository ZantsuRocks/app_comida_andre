import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Bixo with ChangeNotifier {
  String nome;
  int raca; //TODO Fazer "ENUM"
  int idade;
  double peso;
  int tipoRacao; //TODO Fazer "ENUM"
  double pesoDispenser;
  double pesoPote;

  Bixo({
    this.nome = '',
    this.raca = 0,
    this.idade = 0,
    this.peso = 0,
    this.tipoRacao = 0,
    this.pesoDispenser = 0,
    this.pesoPote = 0,
  });
}

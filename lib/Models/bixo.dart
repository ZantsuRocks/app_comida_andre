import 'package:appcomidaandre/Models/agenda.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Bixo with ChangeNotifier {
  String nome;
  String raca;
  int idade;
  double peso;
  String tipoRacao;
  double pesoDispenser;
  double pesoPote;
  List<Agenda> agendas;

  Bixo({
    this.nome = '',
    this.raca = '',
    this.idade = 0,
    this.peso = 0,
    this.tipoRacao = '',
    this.pesoDispenser = 0,
    this.pesoPote = 0,
    this.agendas = const [],
  });
}

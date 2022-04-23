import 'dart:typed_data';

import 'package:appcomidaandre/Models/agenda.dart';
import 'package:flutter/material.dart';

class Bixo with ChangeNotifier {
  Uint8List? _foto;
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

  replaceFromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    raca = json['raca'];
    idade = json['idade'];
    peso = json['peso'];
    tipoRacao = json['racao'];
    pesoDispenser = json['pdisp'];
    pesoPote = json['ppote'];
    agendas = json['agendas'];
  }

  set fotoAsBytes(Uint8List bytes) {
    _foto = bytes;
  }

  Uint8List get fotoAsBytes => _foto ?? Uint8List(0);
}

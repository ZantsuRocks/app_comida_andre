import 'dart:typed_data';

import 'package:appcomidaandre/Models/agenda.dart';
import 'package:flutter/material.dart';

class Bixo with ChangeNotifier {
  Uint8List? _foto;
  String nome;
  String raca;
  int idade;
  num peso;
  String tipoRacao;
  num pesoDispenser;
  num pesoPote;
  bool comFome;
  int tempoComer;
  List<Agenda> agendas;

  Bixo({
    this.nome = '',
    this.raca = '',
    this.idade = 0,
    this.peso = 0,
    this.tipoRacao = '',
    this.pesoDispenser = 0,
    this.pesoPote = 0,
    this.comFome = false,
    this.tempoComer = 0,
    this.agendas = const [],
  });

  void replaceFromJson(Map<String, dynamic> json) {
    nome = json['nome'] ?? '';
    raca = json['raca'] ?? '';
    idade = json['idade'] ?? 0;
    peso = json['peso'] ?? 0;
    tipoRacao = json['tipoRacao'] ?? '';
    pesoDispenser = json['pesoDispenser'] ?? 0;
    pesoPote = json['pesoPote'] ?? 0;
    comFome = json['comFome'] ?? false;
    tempoComer = json['tempoComer'] ?? 0;

    agendas = [];
    for (Map<String, dynamic> e in json['agendas']) {
      agendas.add(
        Agenda(
          hora: e['hora'],
          minuto: e['minuto'],
          peso: e['peso'],
        ),
      );
    }
    //agendas = json['agendas'];
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> toReturn = {};

    toReturn['nome'] = nome;
    toReturn['raca'] = raca;
    toReturn['idade'] = idade;
    toReturn['peso'] = peso;
    toReturn['tipoRacao'] = tipoRacao;
    toReturn['pesoDispenser'] = pesoDispenser;
    toReturn['pesoPote'] = pesoPote;
    toReturn['comFome'] = comFome;
    toReturn['tempoComer'] = tempoComer;

    toReturn['agendas'] = [];
    for (Agenda e in agendas) {
      toReturn['agendas'].add(
        {
          'hora': e.hora,
          'minuto': e.minuto,
          'peso': e.peso,
        },
      );
    }

    return toReturn;
  }

  set fotoAsBytes(Uint8List bytes) {
    _foto = bytes;
    notifyListeners();
  }

  Uint8List get fotoAsBytes => _foto ?? Uint8List(0);
}

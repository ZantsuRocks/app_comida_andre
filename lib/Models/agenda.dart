class Agenda {
  final DateTime _hora;
  final num peso;

  Agenda({int hora = 0, int minuto = 0, this.peso = 1}) : _hora = DateTime(2022, 1, 1, hora, minuto);

  int get hora => _hora.hour;
  int get minuto => _hora.minute;

  String get horario => hora.toString().padLeft(2, '0') + ':' + minuto.toString().padLeft(2, '0');
}

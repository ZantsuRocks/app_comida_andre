import 'package:appcomidaandre/Models/agenda.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../Models/bixo.dart';

class PetPage extends StatefulWidget {
  const PetPage({Key? key}) : super(key: key);

  @override
  State<PetPage> createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> {
  Logger logger = Logger();
  late List<Agenda> agendas;

  late ScrollController _scrollController;
  late TextEditingController _nomeDoPetCont, _idadeDoPetCont, _pesoDoPetCont, _racaoDoPetCont, _alarmeRacao;

  @override
  Widget build(BuildContext context) {
    List<Widget> agendasToScreen = [];

    for (int i = 0; i < agendas.length; i++) {
      agendasToScreen.add(
        ListTile(
          leading: const Icon(Icons.delete),
          title: Text('Horario: ' + agendas[i].horario),
          trailing: Text('${agendas[i].peso}g'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Image.asset(
          'assets/images/logoFullWhite.png',
          fit: BoxFit.fitHeight,
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.save)),
        ],
      ),
      body: ListView(
        controller: _scrollController,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage('assets/images/GatoApp.jpg'), opacity: 0.5), //TODO Imagem do ESP
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          size: 60,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 150),
                      child: Image.asset(
                        'assets/images/logoPD.png',
                        height: 50,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            title: TextField(
              controller: _nomeDoPetCont,
              decoration: const InputDecoration(labelText: 'Nome do Pet'),
            ),
          ),
          ListTile(
            title: TextField(
              controller: _idadeDoPetCont,
              decoration: const InputDecoration(labelText: 'Idade do Pet'),
            ),
          ),
          ListTile(
            title: TextField(
              controller: _pesoDoPetCont,
              decoration: const InputDecoration(labelText: 'Peso do Pet'),
            ),
          ),
          ListTile(
            title: TextField(
              controller: _racaoDoPetCont,
              decoration: const InputDecoration(labelText: 'Ração do Pet'),
            ),
          ),
          ListTile(
            title: TextField(
              decoration: const InputDecoration(labelText: 'Alarme de Ração'),
            ),
          ),
          ListTile(
            title: const Text('Alarme de Alimentação'),
            trailing: Text('00:00'),
          ),
          ListTile(
            title: const Text('Alimentações'),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
            ),
          ),
          ...agendasToScreen
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _nomeDoPetCont = TextEditingController();
    _idadeDoPetCont = TextEditingController();
    _pesoDoPetCont = TextEditingController();
    _racaoDoPetCont = TextEditingController();
    _alarmeRacao = TextEditingController();

    SchedulerBinding.instance?.addPostFrameCallback((dur) {
      _nomeDoPetCont.text = context.read<Bixo>().nome;
      _idadeDoPetCont.text = context.read<Bixo>().idade.toString();
      _pesoDoPetCont.text = context.read<Bixo>().peso.toString();
      _racaoDoPetCont.text = context.read<Bixo>().tipoRacao;
    });

    agendas = [
      Agenda(hora: 18, minuto: 07, peso: 5),
      Agenda(hora: 18, minuto: 08, peso: 6),
      Agenda(hora: 18, minuto: 09, peso: 7),
    ];
  }
}

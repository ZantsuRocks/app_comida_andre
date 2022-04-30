import 'dart:io';

import 'package:appcomidaandre/Models/agenda.dart';
import 'package:appcomidaandre/Repositories/bixo_repo.dart';
import 'package:file_picker/file_picker.dart';
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
  late List<Agenda> _agendas;

  late ScrollController _scrollController;
  late TextEditingController _nomeDoPetCont, _idadeDoPetCont, _pesoDoPetCont, _racaoDoPetCont, _alarmeRacao;
  String? _errIdade, _errPeso;
  late Image _petFoto;

  File? file;

  @override
  Widget build(BuildContext context) {
    List<Widget> agendasToScreen = [];

    for (int i = 0; i < _agendas.length; i++) {
      agendasToScreen.add(
        ListTile(
          leading: IconButton(
              onPressed: () {
                _agendas.removeAt(i);
                setState(() {});
              },
              icon: const Icon(Icons.delete)),
          title: Text('Horario: ' + _agendas[i].horario),
          trailing: Text('${_agendas[i].peso}g'),
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
          IconButton(
            onPressed: _sendToEsp,
            icon: const Icon(Icons.save),
          ),
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
                    child: GestureDetector(
                      onTap: _changeImage,
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: _petFoto.image, opacity: 0.5),
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
              decoration: InputDecoration(
                labelText: 'Idade do Pet',
                errorText: _errIdade,
              ),
            ),
          ),
          ListTile(
            title: TextField(
              controller: _pesoDoPetCont,
              decoration: InputDecoration(
                labelText: 'Peso do Pet',
                errorText: _errPeso,
              ),
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
              onPressed: () async {
                await _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );

                final TimeOfDay? timeOfDay = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  // initialEntryMode: TimePickerEntryMode.dial,
                );
                if (timeOfDay != null) {
                  //TODO peso
                }
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
    _petFoto = const Image(image: AssetImage('assets/images/logoPD.png'));

    // SchedulerBinding.instance?.addPostFrameCallback((dur) {
    _nomeDoPetCont.text = context.read<Bixo>().nome;
    _idadeDoPetCont.text = context.read<Bixo>().idade.toString();
    _pesoDoPetCont.text = context.read<Bixo>().peso.toString();
    _racaoDoPetCont.text = context.read<Bixo>().tipoRacao;
    _petFoto = Image.memory(context.read<Bixo>().fotoAsBytes);
    _agendas = List.from(context.read<Bixo>().agendas);

    //   setState(() {});
    // });

    // _agendas = [];
  }

  _changeImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      // allowedExtensions: [
      //   'png',
      //   'jpg',
      // ],
    );

    if (result != null) {
      if (result.files.single.path != null) {
        file = File(result.files.single.path ?? '');
        if (file!.lengthSync() > 300000) {
          logger.w('Arquivo maior que 300k');
          return;
        }
        setState(() {
          _petFoto = Image.memory(file!.readAsBytesSync());
        });
      }
    }
  }

  _sendToEsp() async {
    //TODO Chamar repositorio e enviar para o esp
    _validaCampos();

    Bixo currentBixo = context.read<Bixo>();

    Bixo bixoToSend = Bixo(
      nome: _nomeDoPetCont.text,
      idade: int.tryParse(_idadeDoPetCont.text) ?? 0,
      peso: num.tryParse(_pesoDoPetCont.text) ?? 0,
      tipoRacao: _racaoDoPetCont.text,
      agendas: _agendas,
      pesoDispenser: context.read<Bixo>().pesoDispenser,
      pesoPote: context.read<Bixo>().pesoPote,
    );

    await BixoRepo.sendBixo(bixoToSend, bixoToReplace: currentBixo);

    if (file != null) {
      await BixoRepo.sendBixoImage(file!.readAsBytesSync(), bixoToReplace: currentBixo);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Informações salvas.'),
      ),
    );

    Navigator.pop(context);
  }

  bool _validaCampos() {
    bool retorno = true;
    _errIdade = null;
    _errPeso = null;
    if (int.tryParse(_idadeDoPetCont.text) == null) {
      _errIdade = 'Idade deve ser um numero';
      retorno = false;
    }
    if (num.tryParse(_pesoDoPetCont.text) == null) {
      _errIdade = 'Peso deve ser um numero';
      retorno = false;
    }

    return retorno;
  }
}

import 'package:appcomidaandre/Routes/pet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/bixo.dart';
import '../Repositories/bixo_repo.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  Logger logger = Logger();
  late SharedPreferences prefs;
  num? alRacao;

  @override
  Widget build(BuildContext context) {
    DateTime dataAgora = DateTime.now();
    String data = dataAgora.day.toString().padLeft(2, '0') + '/';
    data += dataAgora.month.toString().padLeft(2, '0') + '/';
    data += dataAgora.year.toString().padLeft(4, '0');
    String hora = dataAgora.hour.toString().padLeft(2, '0') + ':';
    hora += dataAgora.minute.toString().padLeft(2, '0');

    Bixo bixoWatch = context.watch<Bixo>();

    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 100,
        title: Image.asset(
          'assets/images/logoFullWhite.png',
          fit: BoxFit.fitHeight,
        ),
        actions: [
          IconButton(onPressed: _refreshButton, icon: const Icon(Icons.refresh)),
          IconButton(onPressed: _settingsButton, icon: const Icon(Icons.settings)),
        ],
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: SizedBox(
                  height: 60,
                  child: Image.asset(
                    'assets/images/pegada.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Text(bixoWatch.raca),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text((alRacao ?? 9999) >= bixoWatch.pesoDispenser ? 'Repor Ração' : 'Tem Ração'),
              Text(bixoWatch.comFome ? 'Não alimentou-se' : 'Alimentou-se'),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                bixoWatch.nome,
                textScaleFactor: 1.8,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
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
                        image: DecorationImage(image: Image.memory(bixoWatch.fotoAsBytes).image),
                        shape: BoxShape.circle,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text(
                    'Idade',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${bixoWatch.idade} Anos'),
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Peso',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${bixoWatch.peso} gramas'),
                ],
              ),
            ],
          ),
          ListTile(
            title: const Text(
              'Tipo de Ração',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Text(bixoWatch.tipoRacao),
          ),
          ListTile(
            title: const Text(
              'Peso de Ração no Dispenser',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Text(bixoWatch.pesoDispenser.toString() + 'g'),
          ),
          ListTile(
            title: const Text(
              'Peso de Ração no pote',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Text(bixoWatch.pesoPote.toString() + 'g'),
          ),
          const Divider(height: 16),
          ListTile(
            title: const Text(
              'Data',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Text(data),
          ),
          ListTile(
            title: const Text(
              'Hora',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Text(hora),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance?.addPostFrameCallback((dur) {
      _loadShared();
    });
  }

  _settingsButton() {
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => const PetPage()));
  }

  _refreshButton() async {
    await BixoRepo.fillBixo(bixoToFill: context.read<Bixo>());
    await BixoRepo.fillBixoImage(bixoToFill: context.read<Bixo>());
  }

  _loadShared() async {
    prefs = await SharedPreferences.getInstance();

    alRacao = prefs.getDouble('alRacao') ?? 0;

    setState(() {});
  }
}

import 'package:appcomidaandre/Routes/pet_page.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../Models/bixo.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  Logger logger = Logger();
  @override
  Widget build(BuildContext context) {
    DateTime dataAgora = DateTime.now();
    String data = dataAgora.day.toString().padLeft(2, '0') + '/';
    data += dataAgora.month.toString().padLeft(2, '0') + '/';
    data += dataAgora.year.toString().padLeft(4, '0');
    String hora = dataAgora.hour.toString().padLeft(2, '0') + ':';
    hora += dataAgora.minute.toString().padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Image.asset(
          'assets/images/logoFullWhite.png',
          fit: BoxFit.fitHeight,
        ),
        actions: [
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
              Text(context.watch<Bixo>().raca),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Repor Ração'),
              Text('Não alimentou-se'),
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
                context.watch<Bixo>().nome,
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
                        image: DecorationImage(image: context.watch<Bixo>().foto.image), //TODO Imagem do ESP
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
                  Text('${context.watch<Bixo>().idade} Anos'),
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Peso',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${context.watch<Bixo>().peso} gramas'),
                ],
              ),
            ],
          ),
          ListTile(
            title: const Text(
              'Tipo de Ração',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Text(context.watch<Bixo>().tipoRacao),
          ),
          ListTile(
            title: const Text(
              'Peso de Ração no Dispenser',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Text(context.watch<Bixo>().pesoDispenser.toString() + 'g'),
          ),
          ListTile(
            title: const Text(
              'Peso de Ração no pote',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Text(context.watch<Bixo>().pesoPote.toString() + 'g'),
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

  _settingsButton() {
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => const PetPage()));
  }
}

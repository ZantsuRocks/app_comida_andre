import 'package:appcomidaandre/Routes/pet_page.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  Logger logger = Logger();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Image.asset(
          'assets/images/logoFullWhite.png',
          fit: BoxFit.fitHeight,
        ),
        actions: [
          IconButton(onPressed: _settingsButton, icon: const Icon(Icons.calendar_month)),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text('Nome do Bixo'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/GatoApp.jpg',
                      width: 180,
                      height: 180,
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
                  Text('Vida'),
                  Text('1 Anos'),
                ],
              ),
              Column(
                children: [
                  Text('Peso'),
                  Text('900 gramas'),
                ],
              ),
            ],
          ),
          ListTile(
            title: Text('Tipo de Ração'),
            trailing: Text('Podrona'),
          ),
          ListTile(
            title: Text('Peso de Ração no Dispensar'),
            trailing: Text('90g'),
          ),
          ListTile(
            title: Text('Peso de Ração no pote'),
            trailing: Text('90g'),
          ),
        ],
      ),
    );
  }

  _settingsButton() {
    logger.d('Agendar');

    Navigator.push(context, MaterialPageRoute(builder: (ctx) => const PetPage()));
  }
}

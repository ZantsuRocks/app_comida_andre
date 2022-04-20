import 'package:app_andre/Routes/SchedulePage.dart';
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
        title: const Text('Visão geral'),
        actions: [
          IconButton(onPressed: _settingsButton, icon: const Icon(Icons.calendar_month)),
        ],
      ),
      body: Container(),
    );
  }

  _settingsButton() {
    logger.d('Agendar');

    Navigator.push(context, MaterialPageRoute(builder: (ctx) => const SchedulePage()));
  }
}

import 'package:appcomidaandre/Routes/overview_page.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({Key? key}) : super(key: key);

  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('APP Comida'),
      ),
      body: Center(
        child: TextButton(
          onPressed: _buttonPress,
          child: const Text('Conectar'),
        ),
      ),
    );
  }

  _buttonPress() {
    logger.d('Conectar');

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('Aguarde'),
        content: Center(
          child: LoadingAnimationWidget.staggeredDotsWave(color: Theme.of(ctx).primaryColor, size: 200),
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 5)).then((value) {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (ctx) => const OverviewPage()));
    });
  }
}

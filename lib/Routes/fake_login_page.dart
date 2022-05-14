import 'package:appcomidaandre/Models/bixo.dart';
import 'package:appcomidaandre/Routes/overview_page.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:wifi_iot/wifi_iot.dart';

import '../Repositories/bixo_repo.dart';

class FakeLoginPage extends StatefulWidget {
  const FakeLoginPage({Key? key}) : super(key: key);

  @override
  State<FakeLoginPage> createState() => _FakeLoginPageState();
}

class _FakeLoginPageState extends State<FakeLoginPage> {
  final Logger logger = Logger();

  late TextEditingController _userCont;
  late TextEditingController _passCont;
  bool _hidePassword = true;
  String? _userError, _passError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 48.0, left: 8.0, right: 8.0),
              child: Center(
                child: Image.asset('assets/images/logoFull.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _userCont,
                decoration: InputDecoration(
                  errorText: _userError,
                  labelText: 'Login',
                  hintText: 'seu-usuario',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _passCont,
                obscureText: _hidePassword,
                decoration: InputDecoration(
                  errorText: _passError,
                  labelText: 'Senha',
                  hintText: 'sua-senha',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: _hidePassword ? Theme.of(context).disabledColor : Theme.of(context).primaryColor,
                    ),
                    onPressed: _showPass,
                  ),
                ),
              ),
            ),
            TextButton(onPressed: _loginAction, child: const Text('Entrar')),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _userCont = TextEditingController();
    _passCont = TextEditingController();

    // Future.delayed(const Duration(seconds: 2)).then((value) => FlutterNativeSplash.remove());
  }

  _loginAction() async {
    if (!_loginFieldsValid()) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('Aguarde'),
        content: SizedBox(
          height: 90,
          child: Center(
            child: LoadingAnimationWidget.staggeredDotsWave(color: Theme.of(ctx).primaryColor, size: 50),
          ),
        ),
      ),
    );

    try {
      String passToConnect = 'dosadorpet';
      String ssidToConnect = 'dosador_pet';
      await WiFiForIoTPlugin.findAndConnect(ssidToConnect, password: passToConnect);
      int tempoFaltando = 15;
      while (await WiFiForIoTPlugin.getSSID() != ssidToConnect) {
        await Future.delayed(const Duration(seconds: 1));
        if (tempoFaltando-- <= 0) throw ('Tempo limite de conexão excedido.');
      }
      await WiFiForIoTPlugin.forceWifiUsage(true);

      await BixoRepo.fillBixo(bixoToFill: context.read<Bixo>());
      await BixoRepo.fillBixoImage(bixoToFill: context.read<Bixo>());
      RESTHelper.sendHora(); //Não precisa esperar isso pra logar.
      _userCont.text = '';
      _passCont.text = '';

      Navigator.pop(context);

      Navigator.push(context, MaterialPageRoute(builder: (ctx) => const OverviewPage()));
    } catch (err) {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          backgroundColor: Theme.of(context).errorColor,
          content: const Text('Falha ao conectar-se'),
        ),
      );
    }
  }

  bool _loginFieldsValid() {
    _userError = null;
    _passError = null;
    bool retorno = true;
    if (_userCont.text == '') {
      _userError = 'Usuário não pode ser vazio';
      retorno = false;
    }
    if (_passCont.text == '') {
      _passError = 'Senha não pode ser vazia';
      retorno = false;
    }
    setState(() {});
    return retorno;
  }

  _showPass() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }
}

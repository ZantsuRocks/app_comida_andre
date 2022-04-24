import 'package:appcomidaandre/Models/bixo.dart';
import 'package:appcomidaandre/Routes/overview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

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

    //TODO Catar o ESP e conectar, mandar tbm hora, só depois liberar proxima rota.
    try {
      await BixoRepo.fillBixo(bixoToFill: context.read<Bixo>());
      _userCont.text = '';
      _passCont.text = '';

      Navigator.pop(context);

      await BixoRepo.fillBixoImage(bixoToFill: context.read<Bixo>());

      Navigator.push(context, MaterialPageRoute(builder: (ctx) => const OverviewPage()));

      // rootBundle.load('assets/images/GatoApp.jpg').then((val) {
      //   context.read<Bixo>().fotoAsBytes = val.buffer.asUint8List();

      //   Navigator.push(context, MaterialPageRoute(builder: (ctx) => const OverviewPage()));
      // });
    } catch (err) {
      //TODO Erro
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

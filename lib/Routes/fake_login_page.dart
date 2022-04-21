import 'package:appcomidaandre/Routes/overview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class FakeLoginPage extends StatefulWidget {
  const FakeLoginPage({Key? key}) : super(key: key);

  @override
  State<FakeLoginPage> createState() => _FakeLoginPageState();
}

class _FakeLoginPageState extends State<FakeLoginPage> {
  final Logger logger = Logger();

  late TextEditingController _userCont;
  late TextEditingController _passCont;
  bool hidePassword = true;

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
                decoration: const InputDecoration(
                  labelText: 'Login',
                  hintText: 'seu-usuario',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _passCont,
                obscureText: hidePassword,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  hintText: 'sua-senha',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: hidePassword ? Theme.of(context).disabledColor : Theme.of(context).primaryColor,
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
  }

  _loginAction() {
    logger.d('Login');

    Navigator.push(context, MaterialPageRoute(builder: (ctx) => const OverviewPage()));
  }

  _showPass() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }
}

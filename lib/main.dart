import 'package:appcomidaandre/Models/bixo.dart';
import 'package:appcomidaandre/Routes/fake_login_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

void main() {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  if (kReleaseMode) Logger.level = Level.warning;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Bixo()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Portion',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.teal,
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.teal),
          bodyText2: TextStyle(color: Colors.teal),
        ),
      ),
      home: const FakeLoginPage(),
    );
  }
}

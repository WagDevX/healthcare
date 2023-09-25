import 'package:flutter/material.dart';
import 'package:healthcare/pages/calculardora_imc_page.dart';
import 'package:healthcare/splash/splash.dart';
import 'package:hive/hive.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

Map<int, String> script = {
  1: ''' CREATE TABLE pessoa (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT,
          peso REAL,
          altura REAL
          );'''
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var documentsDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(documentsDirectory.path);
  Future<Database> iniciarBancoDeDados() async {
    var db = await openDatabase(
        path.join(await getDatabasesPath(), 'database.db'),
        version: script.length, onCreate: (Database db, int version) async {
      for (var i = 1; i <= script.length; i++) {
        await db.execute(script[i]!);
        debugPrint(script[i]!);
      }
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      for (var i = oldVersion + 1; i <= script.length; i++) {
        await db.execute(script[i]!);
        debugPrint(script[i]!);
      }
    });
    return db;
  }

  await iniciarBancoDeDados();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    precacheImage(
        const AssetImage('lib/assets/images/backgroundv_2.jpg'), context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const Splash(),
        '/calculadora': (context) => const CalculadoraImcPage(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
    );
  }
}

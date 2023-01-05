import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:humab/models/agenda.dart';
import 'package:humab/models/contactos.dart';
import 'package:humab/models/injecao.dart';
import 'package:humab/models/notas.dart';
import 'package:humab/providers/agenda_provider.dart';
import 'package:humab/providers/contactos_provider.dart';
import 'package:humab/providers/definicoes_provider.dart';
import 'package:humab/providers/injecao_provider.dart';
import 'package:humab/providers/notas_provider.dart';
import 'package:humab/routes.dart';
import 'package:humab/screens/home/home_screen.dart';
import 'package:humab/screens/welcome/welcome_screen.dart';
import 'package:humab/theme.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:hive/hive.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

// BANNER ca-app-pub-3940256099942544/6300978111

void main() async {
  await Hive.initFlutter();
  await MobileAds.instance.initialize();
  initializeDateFormatting('pt_PT', null);

  Hive.registerAdapter(InjecaoAdapter());
  Hive.registerAdapter(NotasAdapter());
  Hive.registerAdapter(AgendaAdapter());
  Hive.registerAdapter(ContactosAdapter());

  await Hive.openBox('settings', compactionStrategy: (int total, int deleted) {
    return deleted > 20;
  });

  await Hive.openBox<Injecao>('injeccao', compactionStrategy: (int total, int deleted) {
    return deleted > 20;
  });

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Box settingsBox = Hive.box('settings');

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
    );

    final bool showWelcomeScreen = settingsBox.get('welcome', defaultValue: true);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DefinicoesProvider()),
        ChangeNotifierProvider(create: (_) => InjecaoProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => NotasProvider()),
        ChangeNotifierProvider(create: (_) => AgendaProvider()),
        ChangeNotifierProvider(create: (_) => ContactosProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Humab',
        theme: themeData(),
        initialRoute: showWelcomeScreen ? WelcomeScreen.routeName : HomeScreen.routeName,
        routes: routes,
      ),
    );
  }

  @override
  void dispose() {
    Hive.box('notas').compact();
    Hive.box('agenda').compact();
    Hive.box('contactos').compact();
    Hive.box('injeccao').compact();
    Hive.box('settings').compact();
    Hive.close();
    super.dispose();
  }
}

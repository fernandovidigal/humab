import 'package:flutter/material.dart';
import 'package:humab/screens/agenda/adicionar_agenda_screen.dart';
import 'package:humab/screens/agenda/agenda_screen.dart';
import 'package:humab/screens/agenda/editar_agenda_screen.dart';
import 'package:humab/screens/contactos/adicionar_contacto_screen.dart';
import 'package:humab/screens/contactos/contactos_screen.dart';
import 'package:humab/screens/contactos/editar_contacto_scren.dart';
import 'package:humab/screens/definicoes/definicoes_screen.dart';
import 'package:humab/screens/definicoes/screens/genero_settings_screen.dart';
import 'package:humab/screens/definicoes/screens/local_settings_screen.dart';
import 'package:humab/screens/definicoes/screens/periodicidade_settings_screen.dart';
import 'package:humab/screens/home/home_screen.dart';
import 'package:humab/screens/injeccao/injeccao_screen.dart';
import 'package:humab/screens/injeccao/historico_screen.dart';
import 'package:humab/screens/injeccao/seleciona_futura_injecao_screen.dart';
import 'package:humab/screens/notas/adicionar_notas_screen.dart';
import 'package:humab/screens/notas/editar_notas_screen.dart';
import 'package:humab/screens/notas/notas_screen.dart';
import 'package:humab/screens/welcome/welcome_screen.dart';

final Map<String, WidgetBuilder> routes = {
  WelcomeScreen.routeName: (context) => const WelcomeScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  NotasScreen.routeName: (context) => const NotasScreen(),
  AdicionarNotasScreen.routeName: (context) => const AdicionarNotasScreen(),
  EditarNotasScreen.routeName: (context) => const EditarNotasScreen(),
  InjeccaoScreen.routeName: (context) => const InjeccaoScreen(),
  HistoricoScreen.routeName: (context) => const HistoricoScreen(),
  SelecionaFuturaInjecaoScreen.routeName: (context) => const SelecionaFuturaInjecaoScreen(),
  AgendaScreen.routeName: (context) => AgendaScreen(),
  AdicionarAgendaScreen.routeName: (context) => const AdicionarAgendaScreen(),
  EditarAgendaScreen.routeName: (context) => const EditarAgendaScreen(),
  ContactosScreen.routeName: (context) => const ContactosScreen(),
  AdicionarContactoScreen.routeName: (context) => const AdicionarContactoScreen(),
  EditarContactoScreen.routeName: (context) => const EditarContactoScreen(),
  DefinicoesScreen.routeName: (context) => const DefinicoesScreen(),
  GeneroSettingsScreen.routeName: (context) => const GeneroSettingsScreen(),
  LocalSettingsScreen.routeName: (context) => const LocalSettingsScreen(),
  PeriodicidadeSettingsScreen.routeName: (context) => const PeriodicidadeSettingsScreen(),
};

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DefinicoesProvider extends ChangeNotifier {
  late int _genero;
  late int _localAdministracao;
  late int _localInjeccao;
  late int _periodicidade;
  late bool _welcome;
  late final Box _definicoesDB;

  DefinicoesProvider() {
    _definicoesDB = Hive.box('settings');
    _genero = _definicoesDB.get('genero') ?? 0;
    _localAdministracao = _definicoesDB.get('localAdministracao') ?? 0;
    _localInjeccao = _definicoesDB.get('localInjeccao') ?? 0;
    _periodicidade = _definicoesDB.get('periodicidade') ?? 0;
    _welcome = _definicoesDB.get('welcome') ?? true;
  }

  int get genero => _genero;
  int get localAdministracao => _localAdministracao;
  int get localInjeccao => _localInjeccao;
  int get periodicidade => _periodicidade;
  bool get welcome => _welcome;

  set genero(int novoGenero) {
    _definicoesDB.put('genero', novoGenero);
    _genero = novoGenero;
    notifyListeners();
  }

  set localAdministracao(int novoLocalAdministracao) {
    _definicoesDB.put('localAdministracao', novoLocalAdministracao);
    _localAdministracao = novoLocalAdministracao;
    notifyListeners();
  }

  set localInjeccao(int novoLocalInjeccao) {
    _definicoesDB.put('localInjeccao', novoLocalInjeccao);
    _localInjeccao = novoLocalInjeccao;
    notifyListeners();
  }

  set periodicidade(int novaPeriodicidade) {
    _definicoesDB.put('periodicidade', novaPeriodicidade);
    _periodicidade = novaPeriodicidade;
    notifyListeners();
  }

  set welcome(bool value) {
    _definicoesDB.put('welcome', value);
    _welcome = value;
    notifyListeners();
  }
}

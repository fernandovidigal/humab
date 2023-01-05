import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:humab/models/injecao.dart';

class InjecaoProvider extends ChangeNotifier {
  List<Injecao> _listaInjeccoes = [];
  late final Box<Injecao> _injeccaoDB;
  late final Box _settingsDB;

  InjecaoProvider() {
    _injeccaoDB = Hive.box<Injecao>('injeccao');
    _settingsDB = Hive.box('settings');

    carregaListaInjecoes();
  }

  void checkDatabases() {
    if (!Hive.isBoxOpen('injeccao')) {
      _injeccaoDB = Hive.box<Injecao>('injeccao');
    }

    if (!Hive.isBoxOpen('settings')) {
      _injeccaoDB = Hive.box<Injecao>('settings');
    }
  }

  void carregaListaInjecoes() {
    _listaInjeccoes = _injeccaoDB.values.toList();
  }

  int getLocalAdministracao() {
    return _settingsDB.get('localAdministracao');
  }

  bool registarInjecao(int nLote, int local) {
    // Obter o ultimo registo da base da dados
    final Injecao? _injecao = _injeccaoDB.getAt(_listaInjeccoes.length - 1);
    if (_injecao != null) {
      _injecao.nlote = nLote;
      _injecao.local = local;
      _injecao.hora = DateTime.now();
      _injecao.data = DateTime.now();

      _injeccaoDB.add(
        Injecao(
          data: getDataFuturaInjeccao(),
          local: determinaProximoLocal(local),
        ),
      );

      carregaListaInjecoes();
      notifyListeners();
      return true;
    }

    return false;
  }

  int determinaProximoLocal(int local) {
    final int _localAdministracao = _settingsDB.get('localAdministracao');
    if (_localAdministracao == 0) {
      return local == 3 ? 0 : local + 1;
    } else if (_localAdministracao == 1) {
      return local == 0 ? 1 : 0;
    } else {
      return local == 2 ? 3 : 2;
    }
  }

  void gerarProximaInjeccao(Injecao injeccao) {
    checkDatabases();

    _injeccaoDB.add(injeccao);
    _listaInjeccoes = _injeccaoDB.values.toList();
    notifyListeners();
  }

  Injecao getProximaInjeccao() {
    final Injecao proximaInjeccao = _listaInjeccoes.last;
    return proximaInjeccao;
  }

  DateTime getDataFuturaInjeccao() {
    checkDatabases();
    final periodicidade = _settingsDB.get('periodicidade');
    final daysToAdd = periodicidade == 0 ? 7 : 14;

    final Injecao injecao = _listaInjeccoes.last;
    final DateTime futuraInjecao = injecao.data.add(Duration(days: daysToAdd));

    return futuraInjecao;
  }

  List<Injecao> getHistorico() {
    final List<Injecao> _historico = _listaInjeccoes.reversed.toList();
    _historico.removeAt(0);

    return _historico;
  }

  List<DateTime> getDataInjecoes() {
    final List<DateTime> listaDatas = [];
    for (var injecao in _listaInjeccoes) {
      listaDatas.add(injecao.data);
    }
    return listaDatas;
  }
}

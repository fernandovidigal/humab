import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:humab/models/notas.dart';

class NotasProvider extends ChangeNotifier {
  late final Box<Notas> _notasDB;

  NotasProvider();

  Future<void> loadDatabase() async {
    _notasDB = await Hive.openBox<Notas>('notas', compactionStrategy: (int total, int deleted) {
      return deleted > 20;
    });
  }

  Future<List<Notas>> getListaNotas() async {
    if (!Hive.isBoxOpen('notas')) await loadDatabase();

    List<Notas> _listaNotas = _notasDB.values.toList();
    _listaNotas.sort((a, b) => a.data.compareTo(b.data));
    return _listaNotas;
  }

  Future<void> adicionarNota(Notas nota) async {
    await _notasDB.add(nota);
    notifyListeners();
  }

  Future<void> actualizarNota(Notas nota) async {
    await nota.save();
    notifyListeners();
  }

  Future<Notas> eliminarNota(Notas nota) async {
    final Notas _deletedNota = Notas(data: nota.data, descricao: nota.descricao);
    await nota.delete();

    notifyListeners();
    return _deletedNota;
  }
}

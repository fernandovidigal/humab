import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:humab/models/agenda.dart';

class AgendaProvider extends ChangeNotifier {
  late final Box<Agenda> _agendaDB;

  AgendaProvider();

  Future<void> loadDatabase() async {
    _agendaDB = await Hive.openBox<Agenda>('agenda', compactionStrategy: (int total, int deleted) {
      return deleted > 20;
    });
  }

  Future<List<Agenda>> getListaAgendamentos() async {
    if (!Hive.isBoxOpen('agenda')) await loadDatabase();
    List<Agenda> _listaAgendamentos = _agendaDB.values.toList();
    _listaAgendamentos.sort((a, b) => a.data.compareTo(b.data));

    return _listaAgendamentos;
  }

  Future<List<Agenda>> getAgendamentosIniciais({required int count}) async {
    final _lista = await getListaAgendamentos();
    final _listaInicais = _lista.take(count).toList();
    return _listaInicais;
  }

  Future<void> adicionarAgendamento(Agenda agendamento) async {
    _agendaDB.add(agendamento);
    notifyListeners();
  }

  Future<void> actualizarAgendamento(Agenda agendamento) async {
    await agendamento.save();
    notifyListeners();
  }

  Future<Agenda> eliminarAgendamento(Agenda agendamento) async {
    final Agenda _deletedAgendamento = Agenda(
      data: agendamento.data,
      hora: agendamento.hora,
      tipo: agendamento.tipo,
      local: agendamento.local,
      especialidade: agendamento.especialidade,
      designacao: agendamento.designacao,
      tipoExame: agendamento.tipoExame,
      notas: agendamento.notas,
    );
    await agendamento.delete();

    notifyListeners();
    return _deletedAgendamento;
  }
}

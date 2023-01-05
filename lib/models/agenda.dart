import 'package:hive/hive.dart';

part 'agenda.g.dart';

@HiveType(typeId: 3)
class Agenda extends HiveObject {
  @HiveField(0)
  late int tipo;
  @HiveField(1)
  late DateTime data;
  @HiveField(2)
  late String hora;
  @HiveField(3)
  late String local;
  @HiveField(4)
  String? especialidade;
  @HiveField(5)
  late String tipoExame;
  @HiveField(6)
  String? notas;
  @HiveField(7)
  String? designacao;

  Agenda({
    required this.tipo,
    required this.data,
    required this.hora,
    required this.local,
    this.especialidade,
    required this.tipoExame,
    this.notas,
    this.designacao,
  });
}

import 'package:hive/hive.dart';

part 'notas.g.dart';

@HiveType(typeId: 1)
class Notas extends HiveObject {
  @HiveField(0)
  late DateTime data;

  @HiveField(1)
  late String? titulo;

  @HiveField(2)
  late String descricao;

  Notas({
    required this.data,
    this.titulo,
    required this.descricao,
  });
}

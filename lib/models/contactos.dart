import 'package:hive/hive.dart';

part 'contactos.g.dart';

@HiveType(typeId: 4)
class Contactos extends HiveObject {
  @HiveField(0)
  late int tipo;
  @HiveField(1)
  late String nome;
  @HiveField(2)
  late String local;
  @HiveField(5)
  late String especialidade;
  @HiveField(3)
  int? contacto;
  @HiveField(4)
  String? email;

  Contactos({
    required this.tipo,
    required this.nome,
    required this.local,
    required this.especialidade,
    this.contacto,
    this.email,
  });
}

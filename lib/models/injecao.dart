import 'package:hive/hive.dart';
import 'package:humab/constants.dart';

part 'injecao.g.dart';

@HiveType(typeId: 2)
class Injecao extends HiveObject {
  @HiveField(0)
  late DateTime data;
  @HiveField(1)
  late DateTime? hora;
  @HiveField(2)
  late int local;
  @HiveField(3)
  late int? nlote;

  Injecao({
    required this.data,
    this.hora,
    required this.local,
    this.nlote,
  });

  Injecao.fromMap(Map<String, dynamic> map) {
    data = DateTime.parse(map['data']);
    hora = map['hora'];
    local = map['local'];
    nlote = map['nlote'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {'data': data.toIso8601String(), 'hora': hora, 'local': local, 'nlote': nlote};

    return map;
  }

  bool isToday() {
    DateTime hoje = DateTime.now();

    if (data.day == hoje.day && data.month == hoje.month && data.year == hoje.year) {
      return true;
    }
    return false;
  }

  String formatedDate() {
    String dia = data.day.toString();
    int mes = data.month;
    return dia + " de " + meses[mes - 1]['mes']!;
  }
}

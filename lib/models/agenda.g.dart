// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agenda.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AgendaAdapter extends TypeAdapter<Agenda> {
  @override
  final int typeId = 3;

  @override
  Agenda read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Agenda(
      tipo: fields[0] as int,
      data: fields[1] as DateTime,
      hora: fields[2] as String,
      local: fields[3] as String,
      especialidade: fields[4] as String?,
      tipoExame: fields[5] as String,
      notas: fields[6] as String?,
      designacao: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Agenda obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.tipo)
      ..writeByte(1)
      ..write(obj.data)
      ..writeByte(2)
      ..write(obj.hora)
      ..writeByte(3)
      ..write(obj.local)
      ..writeByte(4)
      ..write(obj.especialidade)
      ..writeByte(5)
      ..write(obj.tipoExame)
      ..writeByte(6)
      ..write(obj.notas)
      ..writeByte(7)
      ..write(obj.designacao);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AgendaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

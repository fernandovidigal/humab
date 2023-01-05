// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notas.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotasAdapter extends TypeAdapter<Notas> {
  @override
  final int typeId = 1;

  @override
  Notas read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Notas(
      data: fields[0] as DateTime,
      titulo: fields[1] as String?,
      descricao: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Notas obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.data)
      ..writeByte(1)
      ..write(obj.titulo)
      ..writeByte(2)
      ..write(obj.descricao);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotasAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injecao.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InjecaoAdapter extends TypeAdapter<Injecao> {
  @override
  final int typeId = 2;

  @override
  Injecao read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Injecao(
      data: fields[0] as DateTime,
      hora: fields[1] as DateTime?,
      local: fields[2] as int,
      nlote: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Injecao obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.data)
      ..writeByte(1)
      ..write(obj.hora)
      ..writeByte(2)
      ..write(obj.local)
      ..writeByte(3)
      ..write(obj.nlote);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InjecaoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contactos.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactosAdapter extends TypeAdapter<Contactos> {
  @override
  final int typeId = 4;

  @override
  Contactos read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Contactos(
      tipo: fields[0] as int,
      nome: fields[1] as String,
      local: fields[2] as String,
      especialidade: fields[5] as String,
      contacto: fields[3] as int?,
      email: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Contactos obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.tipo)
      ..writeByte(1)
      ..write(obj.nome)
      ..writeByte(2)
      ..write(obj.local)
      ..writeByte(5)
      ..write(obj.especialidade)
      ..writeByte(3)
      ..write(obj.contacto)
      ..writeByte(4)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactosAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

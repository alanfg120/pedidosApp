// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clienteClass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClienteAdapter extends TypeAdapter<Cliente> {
  @override
  Cliente read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cliente()
      ..nombre = fields[0] as String
      ..cedula = fields[1] as String
      ..direcion = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, Cliente obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.nombre)
      ..writeByte(1)
      ..write(obj.cedula)
      ..writeByte(2)
      ..write(obj.direcion);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productosClass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductoAdapter extends TypeAdapter<Producto> {
  @override
  Producto read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Producto()
      ..id = fields[0] as String
      ..productoNombre = fields[1] as String
      ..precio = fields[2] as int
      ..cantidad = fields[3] as int
      ..select = fields[4] as bool;
  }

  @override
  void write(BinaryWriter writer, Producto obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.productoNombre)
      ..writeByte(2)
      ..write(obj.precio)
      ..writeByte(3)
      ..write(obj.cantidad)
      ..writeByte(4)
      ..write(obj.select);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pedidosClass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PedidoAdapter extends TypeAdapter<Pedido> {
  @override
  Pedido read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pedido()
      ..nombreCliente = fields[0] as String
      ..cedulaCliente = fields[1] as String
      ..direcion = fields[2] as String
      ..productos = (fields[3] as List)?.cast<Producto>()
      ..total = fields[4] as double
      ..fecha = fields[5] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Pedido obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.nombreCliente)
      ..writeByte(1)
      ..write(obj.cedulaCliente)
      ..writeByte(2)
      ..write(obj.direcion)
      ..writeByte(3)
      ..write(obj.productos)
      ..writeByte(4)
      ..write(obj.total)
      ..writeByte(5)
      ..write(obj.fecha);
  }
}

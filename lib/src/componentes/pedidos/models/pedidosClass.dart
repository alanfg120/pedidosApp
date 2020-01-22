import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pedidos/src/componentes/clientes/models/clienteClass.dart';

import 'package:pedidos/src/componentes/productos/models/productosClass.dart';

class Pedido {
  Cliente cliente;
  List<Producto> productos;
  int total;
  DateTime fecha;
  String id;
  bool actualizado;
  bool sincronizado;

  Pedido(
      {this.cliente,
      this.fecha,
      this.id,
      this.productos,
      this.total,
      this.sincronizado,
      this.actualizado});

  Cliente clienteMap(clienteFireBase) {
    return Cliente(
        nombre: clienteFireBase['nombre'],
        cedula: clienteFireBase['cedula'],
        direcion: clienteFireBase['direccion']);
  }

  List<Producto> productosMap(List productoFirebase) {
    List<Producto> productos;

    productos = productoFirebase.map((p) {
      return Producto(
          productoNombre: p['productoNombre'],
          codigo: p['codigo'],
          cantidad: p['cantidad'],
          precio: p['precio'],
          select: p['select']);
    }).toList();

    return productos;
  }

  Pedido.map(DocumentSnapshot firedata) {
    id  = firedata.documentID;
    cliente = clienteMap(firedata.data['cliente']);
    productos = productosMap(firedata.data['productos']);
    fecha = (firedata.data['fecha'] as Timestamp).toDate();
    total = firedata.data['total'];
    sincronizado = firedata.metadata.hasPendingWrites;
  }
}

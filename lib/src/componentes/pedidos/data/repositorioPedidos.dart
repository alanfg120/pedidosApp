import 'package:pedidos/src/componentes/clientes/models/clienteClass.dart';
import 'package:pedidos/src/componentes/pedidos/models/pedidosClass.dart';
import 'package:pedidos/src/componentes/productos/models/productosClass.dart';
import 'package:pedidos/src/plugins/fireBase.dart';


class PedidosRepositorio {
  final String colletion = 'panchita/001/pedidos';

  Future<List<Pedido>> getPedidos() async {
    final documentos = await getDocument(colletion, 'fecha');
    return documentos.documents.map((d) => Pedido.map(d)).toList();
  }

  Stream setPedido(Pedido pedido) {
    
    List productos = _mapProductos(pedido.productos);
    Map cliente = _mapCliente(pedido.cliente);
    return addDocument(colletion, pedido.id, {
      "cliente"   : cliente,
      "productos" : productos,
      "fecha"     : DateTime.now(),
      "total"     : pedido.total
    });
  }

  Stream updatePedido(Pedido pedido) {

    List productos = _mapProductos(pedido.productos);
    Map cliente = _mapCliente(pedido.cliente);
    return updateDocument(colletion, pedido.id, {
      "cliente"   : cliente,
      "productos" : productos,
      "fecha"     : pedido.fecha,
      "total"     : pedido.total
    });
  }

  List _mapProductos(List<Producto> productos) {
   return productos.map((producto) => {
              "productoNombre" : producto.productoNombre,
              "codigo"         : producto.codigo,
              "cantidad"       : producto.cantidad,
              "select"         : producto.select,
              "precio"         : producto.precio
            })
        .toList();
  }

  Map _mapCliente(Cliente cliente) => {
        "nombre"    : cliente.nombre,
        "cedula"    : cliente.cedula,
        "direccion" : cliente.direcion
      };
}

import 'package:pedidos/src/componentes/productos/models/productosClass.dart';
import 'package:pedidos/src/plugins/fireBase.dart';


class ProductosRepocitorio {
  final String colletion = 'panchita/001/productos';

  Future<List<Producto>> getProductos() async {
    final documentos = await getDocument(colletion,'');
    return documentos.documents.map((p) => Producto.map(p)).toList();
  }

  Stream setProducto(Producto producto) {
    return addDocument(colletion, producto.id, {
      "productoNombre" : producto.productoNombre,
      "codigo"         : producto.codigo,
      "cantidad"       : producto.cantidad,
      "select"         : producto.select,
      "precio"         : producto.precio
    });
  }

  Stream updateProducto(Producto producto) => updateDocument(colletion, producto.id,{
      "productoNombre" : producto.productoNombre,
      "codigo"         : producto.codigo,
      "cantidad"       : producto.cantidad,
      "select"         : producto.select,
      "precio"         : producto.precio
    });
  
}

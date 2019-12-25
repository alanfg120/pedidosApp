
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pedidos/src/componentes/productos/models/productosClass.dart';
//import 'package:pedidos/src/plugins/getDataBox.dart';

class ProductosRepocitorio{


Future<List<Producto>> getProductos() async {
    
List<Producto> productos=[];
/* productos = await getDataBox<Producto>('productos'); */
final documentos =await Firestore.instance.collection('panchita/001/productos').getDocuments();
productos = documentos.documents.map((p){
  return Producto.map(p);
})
.toList();
return productos;
} 

Stream<DocumentReference> setProducto(Producto producto)  {

return Firestore.instance.collection('panchita/001/productos').add({
 "productoNombre":producto.productoNombre,
 "codigo":producto.codigo,
 "cantidad":producto.cantidad,
 "select":producto.select,
 "precio":producto.precio
 }).asStream();

}



} 



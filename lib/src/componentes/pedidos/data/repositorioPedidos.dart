
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pedidos/src/componentes/pedidos/models/pedidosClass.dart';
//import 'package:pedidos/src/plugins/getDataBox.dart';

class PedidosRepositorio  {
  
Future<List<Pedido>> getPedidos() async { 
       List<Pedido> pedidos=[]; 
       //pedidos = await getDataBox<Pedido>('pedidos');
       final documentos = await Firestore.instance.collection('panchita/001/pedidos').orderBy("fecha").getDocuments();
       pedidos = documentos.documents.map((d){
       return Pedido.map(d);
       }).toList();
       return pedidos;
}


Stream<DocumentReference> setPedido(Pedido pedido) {

List productos = pedido.productos.map((producto){
return {
 "productoNombre": producto.productoNombre,
 "codigo"        : producto.codigo,
 "cantidad"      : producto.cantidad,
 "select"        : producto.select,
 "precio"        : producto.precio
};
}).toList();

Map cliente = {
"nombre"    : pedido.cliente.nombre,
"cedula"    : pedido.cliente.cedula,
"direccion" : pedido.cliente.direcion
};

return Firestore.instance.collection('panchita/001/pedidos').add({

"cliente"   : cliente,
"productos" : productos,
"fecha"     : DateTime.now(),
"total"     : pedido.total

}).asStream();

 

}
       


}
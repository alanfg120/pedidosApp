
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pedidos/src/componentes/pedidos/models/pedidosClass.dart';
//import 'package:pedidos/src/plugins/getDataBox.dart';

class PedidosRepositorio  {
  
Future<List<Pedido>> getPedidos() async { 
       List<Pedido> pedidos=[]; 
       //pedidos = await getDataBox<Pedido>('pedidos');
       final documentos = await Firestore.instance.collection('panchita/001/pedidos').getDocuments();
       pedidos = documentos.documents.map((d){
       return Pedido.map(d);
       }).toList();
       return pedidos;
}


Future<void> setPedido(Pedido pedido) async{

List productos = pedido.productos.map((producto){
return {
 "productoNombre":producto.productoNombre,
 "codigo":producto.codigo,
 "cantidad":producto.cantidad,
 "select":producto.select,
 "precio":producto.precio
};
}).toList();

Firestore.instance.collection('panchita/001/pedidos').add({

"cedula":pedido.cedula,
"nombreCliente":pedido.nombreCliente,
"direccion":pedido.direcion,
"productos": productos,
"fecha":DateTime.now(),
"total":pedido.total

});

 

}
       


}
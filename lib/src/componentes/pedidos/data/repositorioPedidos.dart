
import 'package:pedidos/src/componentes/pedidos/models/pedidosClass.dart';
import 'package:pedidos/src/plugins/getDataBox.dart';

class PedidosRepositorio  {
  
Future<List<Pedido>> getPedidos() async { 
       List<Pedido> pedidos=[]; 
       pedidos = await getDataBox<Pedido>('pedidos');
       return pedidos;
}


Future<void> setPedido(Pedido pedido) async => add<Pedido>(pedido,'pedidos');
       


}
import 'package:equatable/equatable.dart';
import 'package:pedidos/src/componentes/pedidos/models/pedidosClass.dart';


abstract class PedidosEvent  extends Equatable{
   const PedidosEvent();
   @override
   List<Object> get props => [];       
} 

// Eventos de PedidoPage
class  LoadPedidos extends PedidosEvent{
  @override
  String toString() =>'Obteniendo Pedidos ....';
}
class  UpdatePedidos extends PedidosEvent{
  final Pedido pedido;
  UpdatePedidos(this.pedido);
  @override
   List<Object> get props => [pedido]; 
  @override
  String toString() =>'Actulizando Pedidos ....';
}









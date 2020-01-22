import 'package:equatable/equatable.dart';
import 'package:pedidos/src/componentes/pedidos/models/pedidosClass.dart';

abstract class PedidosState  extends Equatable{
   @override
   List<Object> get props => [];       
} 
class LoadedPedidos  extends PedidosState {

 final List<Pedido> pedidos;
 LoadedPedidos(this.pedidos);
  @override
 List<Object> get props => [pedidos];   
}
class LoadingPedidos extends PedidosState {}
 




 


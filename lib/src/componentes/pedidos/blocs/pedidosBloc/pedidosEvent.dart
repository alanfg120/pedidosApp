import 'package:equatable/equatable.dart';
import 'package:pedidos/src/componentes/pedidos/models/pedidosClass.dart';

abstract class PedidosEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Eventos de PedidoPage
class LoadPedidos extends PedidosEvent {
  @override
  String toString() => 'Obteniendo Pedidos ....';
}

class UpdatePedidos extends PedidosEvent {
  final bool update;
  final Pedido pedido;
  UpdatePedidos(this.pedido, this.update);
  @override
  List<Object> get props => [pedido, update];
  @override
  String toString() => 'Actulizando Pedidos ....';
}

class UploadPedidosFireBase extends PedidosEvent {
  final String id;
  UploadPedidosFireBase(this.id);
  @override
  List<Object> get props => [id];
  @override
  String toString() => 'Subiendo Pedidos  a Firebase....';
}

class DetallesPedidoEvent extends PedidosEvent {
  final Pedido pedido;
  DetallesPedidoEvent(this.pedido);
  @override
  List<Object> get props => [pedido];
  @override
  String toString() => 'Detalle del Pedido ....';
}
 class SearchPedidoEvent  extends PedidosEvent{
  final List<Pedido> pedidos;
  final String query;
  SearchPedidoEvent({this.query,this.pedidos});
   List<Object> get props => [query,pedidos];
  @override
  String toString() => 'Buscar  el Pedido ....';
 }
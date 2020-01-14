import 'package:equatable/equatable.dart';
import 'package:pedidos/src/componentes/clientes/models/clienteClass.dart';
import 'package:pedidos/src/componentes/pedidos/models/pedidosClass.dart';
import 'package:pedidos/src/componentes/productos/models/productosClass.dart';

class FormPedidoEvent extends Equatable {
  FormPedidoEvent();
  @override
  List<Object> get props => [];
}


class AddProducto extends FormPedidoEvent {
  final Producto producto;
  AddProducto({this.producto});
  @override
  List<Object> get props => [producto];
  @override
  String toString() => "Agregando Producto al Pedido..";
}

class AddCliente extends FormPedidoEvent {
  final Cliente cliente;
  AddCliente({this.cliente});
  @override
  List<Object> get props => [cliente];
  @override
  String toString() => "Agregando Cliente al Pedido..";
}

class AddPedido extends FormPedidoEvent {
   @override
   String toString() => "Agregando Pedido a la lista..";
}

class SearchEvent extends FormPedidoEvent {
  final String query;
  final String tipo;
  SearchEvent(this.query, this.tipo);
  @override
  List<Object> get props => [query, tipo];
  @override
  String toString() => "Buscando Produco o Cliente..";
}

class GetProducto extends FormPedidoEvent {
  @override
  String toString() => "Obteniendo lista de Productos..";
}

class GetCliente extends FormPedidoEvent {
  @override
  String toString() => "Obteniendo lista de Clientes..";
}

class ResetProducto extends FormPedidoEvent {
  @override
  String toString() => "Reseteando lista de Productos..";
}

class UpdateProductoForm extends FormPedidoEvent {
  final Producto producto;
  UpdateProductoForm(this.producto);
  @override
  List<Object> get props => [producto];
  @override
  String toString() => 'Actulizando Productos en Pedidos ....';
}

class UpdateClienteForm extends FormPedidoEvent {
  final Cliente cliente;
  UpdateClienteForm(this.cliente);
  @override
  List<Object> get props => [cliente];
  @override
  String toString() => 'Actulizando Clientes en Pedidos....';
}

class DeleteProductoForm extends FormPedidoEvent {
  final String id;
  final int    index;
  DeleteProductoForm(this.id,this.index);
  @override
  List<Object> get props => [id,index];
  String toString() => 'Borrando Producto en Pedidos....';
}

class UpdatePedidoForm extends FormPedidoEvent {
  final Pedido pedido;
  UpdatePedidoForm(this.pedido);
  @override
  List<Object> get props => [pedido];
  String toString() => 'Actulizando Pedido ....';
}
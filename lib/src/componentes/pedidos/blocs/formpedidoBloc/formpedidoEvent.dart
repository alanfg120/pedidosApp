
import 'package:equatable/equatable.dart';
import 'package:pedidos/src/componentes/clientes/models/clienteClass.dart';
import 'package:pedidos/src/componentes/pedidos/models/pedidosClass.dart';
import 'package:pedidos/src/componentes/productos/models/productosClass.dart';

class FormPedidoEvent extends Equatable{
      FormPedidoEvent();
      @override
      List<Object> get props => [];   
}

//
class AddProducto extends FormPedidoEvent {
   final Producto producto;

   AddProducto({this.producto});
   @override
   List<Object> get props => [producto]; 
}
class AddCliente extends FormPedidoEvent {
   final Cliente cliente;

   AddCliente({this.cliente});
   @override
   List<Object> get props => [cliente]; 
}

class  AddPedido   extends FormPedidoEvent{
  final Pedido pedido;
  AddPedido(this.pedido);
  @override
  List<Object> get props => [pedido];  
}

class SearchEvent extends FormPedidoEvent{
  final String query;
  final String tipo;
  SearchEvent(this.query,this.tipo);
  @override
  List<Object> get props => [query,tipo]; 
}

class GetProducto extends FormPedidoEvent{}
class GetCliente extends FormPedidoEvent{}
class ResetProducto extends FormPedidoEvent{}

class UpdateProductoForm extends FormPedidoEvent{
 final Producto producto;
 UpdateProductoForm(this.producto);
 @override
  List<Object> get props => [producto]; 
}
class UpdateClienteForm extends FormPedidoEvent{
 final Cliente cliente;
 UpdateClienteForm(this.cliente);
 @override
  List<Object> get props => [cliente]; 
}
class DeleteProductoForm extends FormPedidoEvent{
 final int index;
 DeleteProductoForm(this.index);
 @override
  List<Object> get props => [index]; 
}
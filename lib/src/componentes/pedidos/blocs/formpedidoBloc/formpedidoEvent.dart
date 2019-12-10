
import 'package:equatable/equatable.dart';
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

class  AddPedido   extends FormPedidoEvent{
  final Pedido pedido;
  AddPedido(this.pedido);
  @override
  List<Object> get props => [pedido];  
}

class SearchProducto extends FormPedidoEvent{
  final String query;
  SearchProducto(this.query);
  
  @override
  List<Object> get props => [query]; 
}

class GetProducto extends FormPedidoEvent{}
class ResetProducto extends FormPedidoEvent{}

class UpdateProductoForm extends FormPedidoEvent{
 final Producto producto;
 UpdateProductoForm(this.producto);
 @override
  List<Object> get props => [producto]; 
}
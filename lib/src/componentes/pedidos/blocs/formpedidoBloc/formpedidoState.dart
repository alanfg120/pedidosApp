import 'package:equatable/equatable.dart';
import 'package:pedidos/src/componentes/pedidos/models/pedidosClass.dart';
import 'package:pedidos/src/componentes/productos/models/productosClass.dart';

class FormPedidoState extends Equatable {
  final Pedido  pedido;
  final String query;
  final List<Producto> productos;
  FormPedidoState({this.pedido,this.query,this.productos});

  factory FormPedidoState.inicial(){
    final query='';
    final pedido = Pedido();
    pedido.nombreCliente='';
    pedido.cedulaCliente='';
    pedido.direcion='';
    pedido.total=0;
    pedido.productos=[];
    return FormPedidoState(pedido:pedido,query:query,productos:[]);
  }

  FormPedidoState copyWith({
    Pedido pedido,
    String query,
    List<Producto> productos
  }){
    return FormPedidoState(
      pedido:pedido ?? this.pedido,
      query:query ?? this.query,
      productos: productos ?? this.productos
      );
  }
  @override
  List<Object> get props => [pedido,query,productos];

   
}

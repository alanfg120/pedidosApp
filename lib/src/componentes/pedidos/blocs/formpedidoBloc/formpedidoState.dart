import 'package:equatable/equatable.dart';
import 'package:pedidos/src/componentes/clientes/models/clienteClass.dart';
import 'package:pedidos/src/componentes/pedidos/models/pedidosClass.dart';
import 'package:pedidos/src/componentes/productos/models/productosClass.dart';

class FormPedidoState extends Equatable {
  final Pedido pedido;
  final String query;
  final List<Producto> productos;
  final List<Cliente> clientes;

  FormPedidoState({
                  this.pedido, 
                  this.query, 
                  this.productos,
                  this.clientes
                  
                  });

  factory FormPedidoState.inicial() {
    final query = '';
    final pedido = Pedido(
      id: '',
      cedula: '',
      nombreCliente: '',
      direcion: '',
      productos: [],
      total: 0,
    );

    return FormPedidoState(pedido: pedido, query: query, productos: [],clientes: []);
  }

  FormPedidoState copyWith(
      {Pedido pedido, String query, List<Producto> productos,List<Cliente> clientes}) {
    return FormPedidoState(
        pedido: pedido ?? this.pedido,
        query: query ?? this.query,
        productos: productos ?? this.productos,
        clientes: clientes ?? this.clientes
        );
  }

  int total(List<Producto> productos) {
    int ptotal = 0;
    productos.forEach((p) {
      ptotal = ptotal + (p.cantidad * p.precio);
    });
    pedido.total = ptotal;
    return ptotal;
  }
   
  getCliente(Cliente cliente){
    
    pedido.nombreCliente = cliente.nombre;
    pedido.cedula        = cliente.cedula;
    pedido.direcion      = cliente.direcion;
  }

  @override
  List<Object> get props => [pedido, query, productos,clientes];
}

import 'package:equatable/equatable.dart';
import 'package:pedidos/src/componentes/clientes/models/clienteClass.dart';
import 'package:pedidos/src/componentes/pedidos/models/pedidosClass.dart';
import 'package:pedidos/src/componentes/productos/models/productosClass.dart';

class FormPedidoState extends Equatable {
  final Pedido pedido;
  final String query;
  final List<Producto> productos;
  final List<Cliente> clientes;
  final Cliente cliente;
  FormPedidoState(
      {this.pedido, this.query, this.productos, this.clientes, this.cliente});

  factory FormPedidoState.inicial() {
    final query = '';
    final pedido = Pedido(
        id: '',
        cliente: Cliente(
            nombre: '',
            cedula: '',
            direcion: '',
            select: false,
            sincronizado: true),
        productos: [],
        total: 0,
        sincronizado: true);

    return FormPedidoState(
        pedido: pedido, query: query, productos: [], clientes: []);
  }

  FormPedidoState copyWith(
      {Pedido pedido,
      String query,
      List<Producto> productos,
      List<Cliente> clientes}) {
    return FormPedidoState(
        pedido: pedido ?? this.pedido,
        query: query ?? this.query,
        productos: productos ?? this.productos,
        clientes: clientes ?? this.clientes);
  }

  int total(List<Producto> productos) {
    int ptotal = 0;
    productos.forEach((p) {
      ptotal = ptotal + (p.cantidad * p.precio);
    });
    pedido.total = ptotal;
    return ptotal;
  }

  getCliente(Cliente cliente) {
    pedido.cliente = cliente;
  }

  @override
  List<Object> get props => [pedido, query, productos, clientes, cliente];
}

import 'package:bloc/bloc.dart';
import 'package:pedidos/src/componentes/clientes/data/repositorioCliente.dart';
import 'package:pedidos/src/componentes/clientes/models/clienteClass.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/formpedidoBloc/formpedidoEvent.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/formpedidoBloc/formpedidoState.dart';
import 'package:pedidos/src/componentes/pedidos/data/repositorioPedidos.dart';
import 'package:pedidos/src/componentes/productos/data/repositorioProductos.dart';
import 'package:pedidos/src/componentes/productos/models/productosClass.dart';

class FormPedidosBloc extends Bloc<FormPedidoEvent, FormPedidoState> {
  PedidosRepositorio repo;
  ProductosRepocitorio repoProducto = ProductosRepocitorio();
  ClientesRepositorio repoCliente = ClientesRepositorio();


  List<Cliente> initialClientes;
  List<Producto> initialProductos;
  FormPedidosBloc({this.repo});

  @override
  FormPedidoState get initialState => FormPedidoState.inicial();

  @override
  Stream<FormPedidoState> mapEventToState(FormPedidoEvent event) async* {
    if (event is AddPedido) yield* _mapAddpedidoState();
    if (event is AddProducto) yield* _mapAddproductoState(event);
    if (event is AddCliente) yield* _mapAddClienteState(event);
    if (event is SearchEvent) yield* _mapSearchEventState(event);
    if (event is GetProducto) yield* _mapGetProductoState();
    if (event is GetCliente) yield* _mapetClienteState();
    if (event is UpdateProductoForm) yield* _mapUpdateProductoFormstate(event);
    if (event is UpdateClienteForm) yield* _mapUpdateClienteFormState(event);
    if (event is ResetProducto) yield* _mapResetProductostate();
    if (event is DeleteProductoForm) yield* _mapDeleteProductoFormstate(event);
    if (event is UpdatePedidoForm) yield* _mapUpdatePedidoFormState(event);
  }

  Stream<FormPedidoState> _mapAddpedidoState() async* {
    yield state.copyWith(
        pedido: initialState.pedido,
        query: '',
        productos: state.productos,
        update: false);
  }

  Stream<FormPedidoState> _mapAddproductoState(AddProducto event) async* {

    bool exits = false;
    state.pedido.productos.forEach((p) {
      if (p.codigo == event.producto.codigo) exits = true;
    });
    if (!exits) state.pedido.productos.add(event.producto);
    yield state.copyWith(
        pedido: state.pedido, query: state.query, productos: state.productos);
  }

  Stream<FormPedidoState> _mapSearchEventState(SearchEvent event) async* {
    if (event.query.isEmpty) {
      if (initialProductos.isEmpty || initialClientes.isEmpty) {
        if (event.tipo == 'productos') add(GetProducto());
        if (event.tipo == 'clientes') add(GetCliente());
      }

      yield state.copyWith(
          pedido: state.pedido,
          query: event.query,
          productos: initialProductos ?? state.productos,
          clientes: initialClientes ?? state.clientes);
    } else {
      if (event.tipo == 'productos') {
        final listaSugerida = state.productos
            .where((p) => p.productoNombre
                .toLowerCase()
                .startsWith(event.query.toLowerCase()))
            .toList();
        yield state.copyWith(
            pedido: state.pedido,
            query: event.query,
            productos: listaSugerida,
            clientes: state.clientes);
      }

      if (event.tipo == 'clientes') {
        final listaSugerida = state.clientes
            .where((c) =>
                c.nombre.toLowerCase().startsWith(event.query.toLowerCase()))
            .toList();
        yield state.copyWith(
            pedido: state.pedido,
            query: event.query,
            clientes: listaSugerida,
            productos: state.productos);
      }
    }
  }

  Stream<FormPedidoState> _mapGetProductoState() async* {
    initialProductos = await repoProducto.getProductos();
    yield state.copyWith(
        pedido: state.pedido,
        query: '',
        productos: initialProductos,
        clientes: state.clientes);
  }

  Stream<FormPedidoState> _mapUpdateProductoFormstate(
      UpdateProductoForm event) async* {
    bool exist = false;
    state.productos.forEach((p) {
      if (p.codigo == event.producto.codigo) exist = true;
    });
    if (!exist) state.productos.add(event.producto);
    yield state.copyWith(
        pedido: state.pedido,
        query: '',
        productos: state.productos,
        clientes: state.clientes);
  }

  Stream<FormPedidoState> _mapResetProductostate() async* {
    state.productos.forEach((p) {
      p.cantidad = 1;
      p.select = false;
    });
    state.clientes.forEach((c) => c.select = false);

    yield state.copyWith(
        pedido: state.pedido,
        query: '',
        productos: state.productos,
        clientes: state.clientes);
  }

  Stream<FormPedidoState> _mapDeleteProductoFormstate(
      DeleteProductoForm event) async* {
    state.productos.forEach((p) {
      if (p.id == event.id) p.select = false;
    });
    state.pedido.productos.removeAt(event.index);
    //add(ResetProducto());
    yield state.copyWith(
        pedido: state.pedido, query: '', productos: state.productos);
  }

  Stream<FormPedidoState> _mapetClienteState() async* {
    initialClientes = await repoCliente.getClientes();
    yield state.copyWith(
        pedido: state.pedido,
        query: '',
        clientes: initialClientes,
        productos: state.productos);
  }

  Stream<FormPedidoState> _mapAddClienteState(AddCliente event) async* {
    state.getCliente(event.cliente);
    yield state.copyWith(
        pedido: state.pedido,
        query: '',
        productos: state.productos,
        clientes: state.clientes);
  }

  Stream<FormPedidoState> _mapUpdateClienteFormState(
      UpdateClienteForm event) async* {
    bool exist = false;
    state.clientes.forEach((c) {
      if (c.cedula == event.cliente.cedula) exist = true;
    });
    if (!exist) state.clientes.add(event.cliente);
    yield state.copyWith(
        pedido: state.pedido,
        query: '',
        productos: state.productos,
        clientes: state.clientes);
  }

  Stream<FormPedidoState> _mapUpdatePedidoFormState(
      UpdatePedidoForm event) async* {
    yield state.copyWith(
        query: '',
        pedido: event.pedido,
        update: true,
        productos: state.productos,
        clientes: state.clientes);
  }
}

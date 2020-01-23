import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/pedidosBloc/pedidosEvent.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/pedidosBloc/pedidosState.dart';
import 'package:pedidos/src/componentes/pedidos/data/repositorioPedidos.dart';
import 'package:pedidos/src/componentes/pedidos/models/pedidosClass.dart';

class PedidosBloc extends Bloc<PedidosEvent, PedidosState> {
  PedidosRepositorio repo;
  PedidosBloc({this.repo});
  List<Pedido> initialPedidos;
  @override
  PedidosState get initialState => LoadingPedidos();

  @override
  Stream<PedidosState> mapEventToState(PedidosEvent event) async* {
    if (event is LoadPedidos)           yield* _mapLoadPedidosToState();
    if (event is UpdatePedidos)         yield* _mapUpdatePedidosState(event, state);
    if (event is UploadPedidosFireBase) yield* _mapUploadPedidosFireBaseState(event, state);
    if (event is SearchPedidoEvent)     yield* _searchPedidos(event);
  }

  Stream<PedidosState> _mapLoadPedidosToState() async* {
    initialPedidos = await repo.getPedidos();
    yield LoadedPedidos(initialPedidos);
  }

  Stream<PedidosState> _mapUpdatePedidosState(
      UpdatePedidos event, LoadedPedidos state) async* {
    if (event.update) {
      event.pedido.sincronizado = true;
      repo.updatePedido(event.pedido).listen((data) {
        add(UploadPedidosFireBase(event.pedido.id));
      });
    } else if (event.pedido.productos.length > 0) {
      repo.setPedido(event.pedido).listen((data) {
        add(UploadPedidosFireBase(event.pedido.id));
      });
      event.pedido.fecha = DateTime.now();
      print(event.pedido.productos[0].cantidad);
      state.pedidos.add(event.pedido);
      yield LoadedPedidos(state.pedidos);
    }
  }

  Stream<PedidosState> _mapUploadPedidosFireBaseState(
      UploadPedidosFireBase event, LoadedPedidos state) async* {
    state.pedidos.forEach((p) {
      if (p.id == event.id) p.sincronizado = false;
    });
    yield LoadingPedidos();
    yield LoadedPedidos(state.pedidos);
  }

  Stream<PedidosState> _searchPedidos(SearchPedidoEvent event) async* {
    if (event.query.isEmpty) {
      yield LoadedPedidos([]);
    } else {
      final listaSugerida = event.pedidos
          .where((p) => p.cliente.nombre
              .toLowerCase()
              .startsWith(event.query.toLowerCase()))
          .toList();
      yield LoadedPedidos(listaSugerida);
    }
  }
}

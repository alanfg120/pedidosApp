import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/pedidosBloc/pedidosEvent.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/pedidosBloc/pedidosState.dart';
import 'package:pedidos/src/componentes/pedidos/data/repositorioPedidos.dart';
import 'package:pedidos/src/componentes/pedidos/models/pedidosClass.dart';

class PedidosBloc extends Bloc<PedidosEvent, PedidosState> {
  
  PedidosRepositorio repo;
  PedidosBloc({@required this.repo});
  @override
  PedidosState get initialState => LoadingPedidos();

  @override
  Stream<PedidosState> mapEventToState(PedidosEvent event) async* {
    if (event is LoadPedidos) {
      yield* _mapLoadPedidosToState();
    }
    if (event is UpdatePedidos) {
      yield* _mapUpdatePedidosState(event, state);
    }
  }

  Stream<PedidosState> _mapLoadPedidosToState() async* {
    print(state);
    final List<Pedido> pedidos = await repo.getPedidos();
    yield LoadedPedidos(pedidos);
  }

  Stream<PedidosState> _mapUpdatePedidosState(
      UpdatePedidos event, LoadedPedidos state) async* {
    state.pedidos.add(event.pedido);
    yield LoadedPedidos(state.pedidos);
  }
}

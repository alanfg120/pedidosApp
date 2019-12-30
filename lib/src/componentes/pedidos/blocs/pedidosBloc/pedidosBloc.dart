import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/pedidosBloc/pedidosEvent.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/pedidosBloc/pedidosState.dart';
import 'package:pedidos/src/componentes/pedidos/data/repositorioPedidos.dart';
import 'package:pedidos/src/componentes/pedidos/models/pedidosClass.dart';
import 'package:pedidos/src/plugins/uid.dart';

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
    if (event is UploadPedidosFireBase) {
      yield* _mapUploadPedidosFireBaseState(event, state);
    }
  }

  Stream<PedidosState> _mapLoadPedidosToState() async* {
    final List<Pedido> pedidos = await repo.getPedidos();
    yield LoadedPedidos(pedidos);
  }

  Stream<PedidosState> _mapUpdatePedidosState(
      UpdatePedidos event, LoadedPedidos state) async* {
    repo.setPedido(event.pedido).listen((data) {
      add(UploadPedidosFireBase(event.pedido.id));
    });
    event.pedido.id = createUid();
    event.pedido.fecha = DateTime.now();
    state.pedidos.add(event.pedido);
    yield LoadedPedidos(state.pedidos);
  }

  Stream<PedidosState> _mapUploadPedidosFireBaseState(
      UploadPedidosFireBase event, LoadedPedidos state) async* {
    state.pedidos.forEach((p) {
      if (p.id == event.id) p.sincronizado = false;
    });
    yield LoadingPedidos();
    yield LoadedPedidos(state.pedidos);
  }
}

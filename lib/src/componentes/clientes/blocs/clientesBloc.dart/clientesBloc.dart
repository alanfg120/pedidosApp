import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pedidos/src/componentes/clientes/blocs/clientesBloc.dart/clientesEvent.dart';
import 'package:pedidos/src/componentes/clientes/blocs/clientesBloc.dart/clientesState.dart';
import 'package:pedidos/src/componentes/clientes/data/repositorioCliente.dart';
import 'package:pedidos/src/componentes/clientes/models/clienteClass.dart';

class ClientesBloc extends Bloc<ClientesEvent, ClientesState> {
  ClientesRepositorio repo;
  ClientesBloc({@required this.repo});

  @override
  ClientesState get initialState => LoadingClientes();

  @override
  Stream<ClientesState> mapEventToState(ClientesEvent event) async* {
    if (event is LoadClientes) yield* _mapLoadClientesEvent();
    if (event is UpdateClientes) yield* _mapUpdateClientesEvent(event, state);
    if (event is UploadClientes) yield* _mapUploadClientesEvent();
    if (event is UploadClienteFireBase)
      yield* _mapUploadClienteFireBaseEvent(event, state);
  }

  Stream<ClientesState> _mapLoadClientesEvent() async* {
    final List<Cliente> clientes = await repo.getClientes();
    yield LoadedClientes(clientes);
  }

  Stream<ClientesState> _mapUpdateClientesEvent(
      UpdateClientes event, LoadedClientes state) async* {
    bool exist = false;
    state.clientes.forEach((p) {
      if (p.cedula == event.cliente.cedula) {
        exist = true;
      }
    });
    if (!exist) {
      
      state.clientes.add(event.cliente);
      repo.setCliente(event.cliente).listen((data) {
        add(UploadClienteFireBase(event.cliente.cedula));
      });
    }

    yield LoadedClientes(state.clientes);
  }

  Stream<ClientesState> _mapUploadClientesEvent() async* {
    yield UploadedClientes();
  }

  Stream<ClientesState> _mapUploadClienteFireBaseEvent(
      UploadClienteFireBase event, LoadedClientes state) async* {
         state.clientes.forEach((c){
           if(c.cedula==event.cedula )
             c.sincronizado = false;
         });
         yield LoadingClientes();
         yield LoadedClientes(state.clientes);
      }
}

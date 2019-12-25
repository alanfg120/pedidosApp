import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pedidos/src/componentes/clientes/blocs/clientesBloc.dart/clientesEvent.dart';
import 'package:pedidos/src/componentes/clientes/blocs/clientesBloc.dart/clientesState.dart';
import 'package:pedidos/src/componentes/clientes/data/repositorioCliente.dart';
import 'package:pedidos/src/componentes/clientes/models/clienteClass.dart';

class ClientesBloc extends Bloc<ClientesEvent,ClientesState>{

 ClientesRepositorio repo;
 ClientesBloc({@required this.repo});

  @override
  ClientesState get initialState => LoadingClientes();

  @override
  Stream<ClientesState> mapEventToState(ClientesEvent event) async* {
     if(event is LoadClientes) 
      yield* _mapLoadClientesEvent();
     if(event is UpdateClientes) 
      yield*  _mapUpdateClientesEvent(event,state);
     if(event is UploadClientes) 
      yield* _mapUploadClientesEvent();

  }
      
     Stream<ClientesState> _mapLoadClientesEvent() async* {
     final List<Cliente> clientes = await repo.getClientes();
     yield LoadedClientes(clientes); 

     }

  Stream<ClientesState> _mapUpdateClientesEvent(UpdateClientes event, LoadedClientes state) async*{
    bool exist = false;
    state.clientes.forEach((p){
    if(p.cedula == event.cliente.cedula){
       exist = true;
    }
   });
    if(!exist){
       state.clientes.add(event.cliente);
       repo.setCliente(event.cliente).listen((data){
            //add(UploadProductos());
           
       });
    }
    
    yield LoadedClientes(state.clientes); 

  }

  Stream<ClientesState> _mapUploadClientesEvent() async* {

    yield UploadedClientes();

  }

  

  
}
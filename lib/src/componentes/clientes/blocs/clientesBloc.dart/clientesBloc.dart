import 'package:bloc/bloc.dart';
import 'package:pedidos/src/componentes/clientes/blocs/clientesBloc.dart/clientesEvent.dart';
import 'package:pedidos/src/componentes/clientes/blocs/clientesBloc.dart/clientesState.dart';
import 'package:pedidos/src/componentes/clientes/data/repositorioCliente.dart';
import 'package:pedidos/src/componentes/clientes/models/clienteClass.dart';
import 'package:pedidos/src/plugins/uid.dart';

class ClientesBloc extends Bloc<ClientesEvent, ClientesState> {
  ClientesRepositorio repo;
  ClientesBloc({this.repo});

  @override
  ClientesState get initialState => LoadingClientes();

  @override
  Stream<ClientesState> mapEventToState(ClientesEvent event) async* {
    if (event is LoadClientes) yield* _loadClientes();
    if (event is UpdateClientes) yield* _updateClientes(event, state);
    if (event is UploadClienteFireBase)
      yield* _uploadClientesFirebase(event, state);
    if(event is SearchClientesEvent) yield* _searchClientes(event);
  }

  Stream<ClientesState> _loadClientes() async* {
    final List<Cliente> clientes = await repo.getClientes();
    yield LoadedClientes(clientes);
  }

  Stream<ClientesState> _updateClientes(
      UpdateClientes event, LoadedClientes state) async* {
    if (event.update) {
      repo.updateCliente(event.cliente).listen((data) {
        add(UploadClienteFireBase(event.cliente.cedula));
      });
    } else {
      bool exist = false;
      state.clientes.forEach(
          (p) => p.cedula == event.cliente.cedula ? exist = true : null);
      if (!exist) {
        event.cliente.id = createUid();
        state.clientes.add(event.cliente);
        repo.setCliente(event.cliente).listen((data) {
          add(UploadClienteFireBase(event.cliente.cedula));
        });
      }
    }
    yield LoadedClientes(state.clientes);
  }

  Stream<ClientesState> _uploadClientesFirebase(
      UploadClienteFireBase event, LoadedClientes state) async* {
    state.clientes.forEach((c) {
      if (c.cedula == event.cedula) c.sincronizado = false;
    });
    yield UploadFireBaseClientes();
    yield LoadedClientes(state.clientes);
  }

  Stream<ClientesState> _searchClientes(SearchClientesEvent event) async* {
  
    if (event.query.isEmpty) {
      yield LoadedClientes([]);
    } else {
      final listaSugerida = event.clientes
          .where((p) => p.nombre
              .toLowerCase()
              .startsWith(event.query.toLowerCase()))
          .toList();
      yield LoadedClientes(listaSugerida);
    }

  }
}

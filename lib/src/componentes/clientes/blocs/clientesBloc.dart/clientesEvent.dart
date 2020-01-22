
import 'package:equatable/equatable.dart';
import 'package:pedidos/src/componentes/clientes/models/clienteClass.dart';


class ClientesEvent extends Equatable{
      @override
      List<Object> get props => [];    
}

class  LoadClientes extends ClientesEvent{
  @override
  String toString() =>'Obteniendo Clientes ....';
}
class UploadClientes extends ClientesEvent{
  @override
  String toString() =>'Subiendo Clientes ....';
}
class  UpdateClientes extends ClientesEvent{
  final bool update;
  final Cliente cliente;
  UpdateClientes(this.cliente,this.update);
  @override
  List<Object> get props => [cliente,update];
  @override
  String toString() =>'Actulizando Clientes ....';
}
class  UploadClienteFireBase extends ClientesEvent{
  final String cedula;
  UploadClienteFireBase(this.cedula);
  @override
  List<Object> get props => [cedula];
  @override
  String toString() =>'Subiendo Cliente A firebase ....';
}
class SearchClientesEvent extends ClientesEvent{
  final List<Cliente> clientes;
  final String query;
  SearchClientesEvent({this.query,this.clientes});
    @override
  List<Object> get props => [query,clientes];
  @override
  String toString() =>'Buscando Clientes....';
}


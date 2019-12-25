
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
  final Cliente cliente;
  UpdateClientes(this.cliente);
  @override
  List<Object> get props => [cliente];
  @override
  String toString() =>'Actulizando Clientes ....';
}

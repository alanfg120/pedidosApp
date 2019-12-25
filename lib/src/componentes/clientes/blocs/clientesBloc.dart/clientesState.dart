import 'package:equatable/equatable.dart';
import 'package:pedidos/src/componentes/clientes/models/clienteClass.dart';

class ClientesState extends Equatable{
 List<Object> get props=>[];
}


class LoadingClientes extends ClientesState{}
class UploadedClientes extends ClientesState{}

class LoadedClientes  extends ClientesState{
  final List<Cliente> clientes;
  LoadedClientes(this.clientes);
  List<Object> get props => [clientes];  

}
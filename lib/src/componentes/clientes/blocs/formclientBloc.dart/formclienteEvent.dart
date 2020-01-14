import 'package:equatable/equatable.dart';
import 'package:pedidos/src/componentes/clientes/models/clienteClass.dart';

class FormClienteEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddclienteForm extends FormClienteEvent {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'Reset Formulario Cliente....';
}

class UpdateCliente extends FormClienteEvent {
  final Cliente cliente;


  UpdateCliente(this.cliente);
  @override
  List<Object> get props => [cliente];
  @override
  String toString() => 'Actulizando Cliente ....';
}

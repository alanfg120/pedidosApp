
import 'package:equatable/equatable.dart';
import 'package:pedidos/src/componentes/clientes/models/clienteClass.dart';

class FormClienteEvent extends Equatable{
  @override
  List<Object> get props => [];
}


class AddclienteForm extends FormClienteEvent{
  
  final Cliente cliente;
  AddclienteForm(this.cliente);
  @override
  List<Object> get props => [cliente];

}
import 'package:equatable/equatable.dart';
import 'package:pedidos/src/componentes/clientes/models/clienteClass.dart';

class FormClienteState extends Equatable {
  final bool updateCliente;
  final Cliente cliente;
  FormClienteState({this.cliente, this.updateCliente});

  factory FormClienteState.inicial() {
    final updateCliente = false;
    final cliente = Cliente(
        id: '',
        cedula: '',
        nombre: '',
        direcion: '',
        select: false,
        sincronizado: true);

    return FormClienteState(cliente: cliente, updateCliente: updateCliente);
  }
  copyWith({Cliente cliente, bool updateCliente}) => FormClienteState(
      cliente: cliente ?? this.cliente,
      updateCliente: updateCliente ?? this.updateCliente);

  @override
  List<Object> get props => [cliente, updateCliente];
}

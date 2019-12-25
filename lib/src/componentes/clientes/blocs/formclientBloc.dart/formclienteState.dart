
import 'package:equatable/equatable.dart';
import 'package:pedidos/src/componentes/clientes/models/clienteClass.dart';

class FormClienteState extends Equatable {
  final Cliente  cliente;
  FormClienteState({this.cliente});

  factory FormClienteState.inicial(){
    final cliente = Cliente(
     id: '',
     cedula: '',
     nombre: '',
     direcion: '',
     select: false
    );
    
    return FormClienteState(cliente: cliente);
  }

 
  @override
  List<Object> get props => [cliente];

   
}

import 'package:equatable/equatable.dart';
import 'package:pedidos/src/componentes/productos/models/productosClass.dart';

class FormProductoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddproductoForm extends FormProductoEvent {

  @override
  List<Object> get props => [];
  String toString() => 'Reset Formulario Producto....';
}
class UpdateproductoForm extends FormProductoEvent {
  final Producto producto;
  UpdateproductoForm(this.producto);
  @override
  List<Object> get props => [producto];
  String toString() => 'Actulizando  Producto....';
}


import 'package:equatable/equatable.dart';
import 'package:pedidos/src/componentes/productos/models/productosClass.dart';

class FormProductoEvent extends Equatable{
  @override
  List<Object> get props => [];
}


class AddproductoForm extends FormProductoEvent{
  
  final Producto producto;
  AddproductoForm(this.producto);
  @override
  List<Object> get props => [producto];

}
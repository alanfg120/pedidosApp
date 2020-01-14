import 'package:equatable/equatable.dart';
import 'package:pedidos/src/componentes/productos/models/productosClass.dart';

class FormProductoState extends Equatable {
  final Producto producto;
  final bool updateProducto;
  FormProductoState({this.producto, this.updateProducto});

  factory FormProductoState.inicial() {
    final bool updateProducto = false;
    final Producto producto = Producto(
      id: '',
      productoNombre: '',
      cantidad: 1,
      precio: 0,
      select: false,
      sincronizado: true,
    );

    return FormProductoState(
        producto: producto, updateProducto: updateProducto);
  }

  FormProductoState copyWith({bool updateProducto, Producto producto}) {
    return FormProductoState(
        producto       : producto       ?? this.producto,
        updateProducto : updateProducto ?? this.updateProducto);
  }

  @override
  List<Object> get props => [producto];
}

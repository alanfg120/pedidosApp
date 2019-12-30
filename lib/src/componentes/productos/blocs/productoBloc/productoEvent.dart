import 'package:equatable/equatable.dart';
import 'package:pedidos/src/componentes/productos/models/productosClass.dart';

class ProductosEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadProductos extends ProductosEvent {
  @override
  String toString() => 'Obteniendo Productos ....';
}

class UploadProductos extends ProductosEvent {
  final String codidoProducto;
  UploadProductos(this.codidoProducto);
  List<Object> get props => [codidoProducto];
  String toString() =>'Subiendo Productos a Firebase....';

}

class UpdateProductos extends ProductosEvent {
  final Producto producto;
  UpdateProductos(this.producto);
  @override
  List<Object> get props => [producto];
  @override
  String toString() => 'Actulizando Productos ....';
}


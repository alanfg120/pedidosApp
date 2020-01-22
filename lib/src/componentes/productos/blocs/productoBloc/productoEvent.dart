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
  final bool update;
  final Producto producto;
  UpdateProductos(this.producto,this.update);
  @override
  List<Object> get props => [producto,update];
  @override
  String toString() => 'Actulizando lista de Productos ....';
}
class SearchProductoEvent extends ProductosEvent {
  final String query;
  final List<Producto> productos;
  SearchProductoEvent(this.productos,this.query);
  @override
  List<Object> get props => [productos,query];
  @override
  String toString() => 'Buscando Producto ....';
}


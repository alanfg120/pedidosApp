
import 'package:equatable/equatable.dart';
import 'package:pedidos/src/componentes/productos/models/productosClass.dart';

class ProductosState extends Equatable{
 List<Object> get props=>[];
}


class LoadingProductos extends ProductosState{}
class UploadedProductos extends ProductosState{}

class LoadedProductos  extends ProductosState{
  final List<Producto> productos;
  LoadedProductos(this.productos);
  List<Object> get props => [productos];  

}
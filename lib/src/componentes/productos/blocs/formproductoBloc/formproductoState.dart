
import 'package:equatable/equatable.dart';
import 'package:pedidos/src/componentes/productos/models/productosClass.dart';

class FormProductoState extends Equatable {
  final Producto  producto;
  FormProductoState({this.producto});

  factory FormProductoState.inicial(){
    final producto = Producto();
     producto.productoNombre = '';
     producto.precio         =  0;
     producto.codigo         =  '';
     producto.cantidad       =  0;
     producto.select         = false;
    return FormProductoState(producto: producto);
  }

 
  @override
  List<Object> get props => [producto];

   
}

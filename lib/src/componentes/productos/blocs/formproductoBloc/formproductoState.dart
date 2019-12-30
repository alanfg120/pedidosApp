
import 'package:equatable/equatable.dart';
import 'package:pedidos/src/componentes/productos/models/productosClass.dart';

class FormProductoState extends Equatable {
  final Producto  producto;
  FormProductoState({this.producto});

  factory FormProductoState.inicial(){
    final producto = Producto(
      id: '',
      productoNombre: '',
      cantidad: 1,
      precio: 0,
      select: false,
      sincronizado: true
    );
    
    return FormProductoState(producto: producto);
  }

 
  @override
  List<Object> get props => [producto];

   
}

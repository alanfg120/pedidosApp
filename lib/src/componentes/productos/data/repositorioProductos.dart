import 'package:pedidos/src/componentes/productos/models/productosClass.dart';
import 'package:pedidos/src/plugins/getDataBox.dart';

class ProductosRepocitorio{


Future<List<Producto>> getProductos() async {

List<Producto> productos=[];
productos = await getDataBox<Producto>('productos');
return productos;

}

Future<void> setProducto(Producto producto) async => add<Producto>(producto,'productos');

} 



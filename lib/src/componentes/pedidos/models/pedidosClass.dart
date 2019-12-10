import 'package:hive/hive.dart';

import 'package:pedidos/src/componentes/productos/models/productosClass.dart';
part 'pedidosClass.g.dart';

@HiveType()
class Pedido{
      @HiveField(0)
      String nombreCliente;
      @HiveField(1)
      String cedulaCliente;
      @HiveField(2)
      String direcion;
      @HiveField(3)
      List<Producto>  productos;
      @HiveField(4)
      double total;
      @HiveField(5)
      DateTime fecha;
}

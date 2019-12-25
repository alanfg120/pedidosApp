import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

import 'package:pedidos/src/componentes/productos/models/productosClass.dart';
part 'pedidosClass.g.dart';

@HiveType()
class Pedido{
      @HiveField(0)
      String nombreCliente;
      @HiveField(1)
      String cedula;
      @HiveField(2)
      String direcion;
      @HiveField(3)
      List<Producto>  productos;
      @HiveField(4)
      int total;
      @HiveField(5)
      DateTime fecha;
      @HiveField(6)
      String id;
      @HiveField(7)
      bool sincronizado;
    
      Pedido({
        this.nombreCliente,
        this.cedula,
        this.direcion,
        this.fecha,
        this.id,
        this.productos,
        this.total,
        this.sincronizado
      });

      Pedido.map(DocumentSnapshot firedata){
       id            = firedata.documentID;
       cedula        = firedata.data['cedula'];
       nombreCliente = firedata.data['nombreCliente'];
       direcion      = firedata.data['direcion'];
       productos     = firedata.data['produtos'];
       fecha         = (firedata.data['fecha'] as Timestamp).toDate();
       total         = firedata.data['total'];
       sincronizado  = firedata.metadata.hasPendingWrites;
      }
      
}

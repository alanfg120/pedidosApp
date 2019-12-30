import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pedidos/src/componentes/clientes/models/clienteClass.dart';

import 'package:pedidos/src/componentes/productos/models/productosClass.dart';



class Pedido{
  
      Cliente cliente;
      List<Producto>  productos;
      int total;
      DateTime fecha;
      String id;
  
      bool sincronizado;
      Pedido({
        this.cliente,
        this.fecha,
        this.id,
        this.productos,
        this.total,
        this.sincronizado
      });
     
    Cliente clienteMap(clienteFireBase){

        return Cliente(
               nombre  : clienteFireBase['nombre'],
               cedula  : clienteFireBase['cedula'],
               direcion: clienteFireBase['direcion'] 
        );
       
      }
      Pedido.map(DocumentSnapshot firedata){
       id            = firedata.documentID;
       cliente       = clienteMap(firedata.data['cliente']);
       productos     = firedata.data['produtos'];
       fecha         = (firedata.data['fecha'] as Timestamp).toDate();
       total         = firedata.data['total'];
       sincronizado  = firedata.metadata.hasPendingWrites;
      }
      
}

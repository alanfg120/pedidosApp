import 'package:cloud_firestore/cloud_firestore.dart';

class Producto{



String id;
String codigo;
String productoNombre;
int precio;
int  cantidad;
bool  select;
bool  sincronizado;

Producto({
  this.id,
  this.codigo,
  this.productoNombre,
  this.precio,
  this.cantidad,
  this.select,
  this.sincronizado
});

 Producto.map(DocumentSnapshot firedata){
   id     = firedata.documentID;
   codigo = firedata.data['codigo'];
   productoNombre = firedata.data['productoNombre'];
   precio = firedata.data['precio'];
   cantidad = firedata.data['cantidad'];
   select = firedata.data['select'];
   sincronizado = firedata.metadata.hasPendingWrites;
 }

}

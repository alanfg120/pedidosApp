import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
part 'productosClass.g.dart';

@HiveType()
class Producto{


@HiveField(0)
String id;
@HiveField(1)
String codigo;
@HiveField(2)
String productoNombre;
@HiveField(3)
int precio;
@HiveField(4)
int  cantidad;
@HiveField(5)
bool  select;

Producto({
  this.id,
  this.codigo,
  this.productoNombre,
  this.precio,
  this.cantidad,
  this.select
});

 Producto.map(DocumentSnapshot firedata){
   id = firedata.documentID;
   codigo=firedata.data['codigo'];
   productoNombre = firedata.data['productoNombre'];
   precio = firedata.data['precio'];
   cantidad = firedata.data['cantidad'];
   select = firedata.data['select'];

 }

}

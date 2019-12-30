import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
part 'clienteClass.g.dart';


@HiveType()

class Cliente {

String id; 
String nombre;
String cedula;
String direcion;
bool   select;
bool   sincronizado;

Cliente({
  this.id,
  this.cedula,
  this.direcion,
  this.nombre,
  this.select,
  this.sincronizado
});

Cliente.map(DocumentSnapshot document){

id       = document.documentID;
cedula   = document.data['cedula'];
nombre   = document.data['nombre'];
direcion = document.data['direccion'];
select   = document.data['select'];
sincronizado = document.metadata.hasPendingWrites;
}
}
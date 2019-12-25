import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
part 'clienteClass.g.dart';


@HiveType()

class Cliente {

String id; 
@HiveField(0)
String nombre;
@HiveField(1)
String cedula;
@HiveField(2)
String direcion;

bool select;

Cliente({
  this.id,
  this.cedula,
  this.direcion,
  this.nombre,
  this.select
});

Cliente.map(DocumentSnapshot document){

id       = document.documentID;
cedula   = document.data['cedula'];
nombre   = document.data['nombre'];
direcion = document.data['direccion'];
select   = document.data['select'];
}
}
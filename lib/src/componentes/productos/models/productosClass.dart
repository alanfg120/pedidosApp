import 'package:hive/hive.dart';
part 'productosClass.g.dart';

@HiveType()
class Producto{

@HiveField(0)
String codigo;
@HiveField(1)
String productoNombre;
@HiveField(2)
double precio;
@HiveField(3)
int  cantidad;
@HiveField(4)
bool  select;

}

import 'package:hive/hive.dart';


  Future<List<T>> getDataBox<T>(String box) async {
   List<T> list=[];
   Box<T>  listbox =  await Hive.openBox<T>(box);
   list   = listbox.values.toList();
  
   return list;     
   }

   Future<void>  add<T>(data,String box) async {
      print("hola");
      Box<T> setbox =  Hive.box<T>(box);
      setbox.add(data);


  }
 
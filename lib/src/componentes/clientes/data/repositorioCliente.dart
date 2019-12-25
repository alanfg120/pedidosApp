
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pedidos/src/componentes/clientes/models/clienteClass.dart';


class ClientesRepositorio  {
  
Future<List<Cliente>> getClientes() async { 
       List<Cliente> clientes=[]; 
       //clientes = await getDataBox<Cliente>('pedidos');
       final documentos = await Firestore.instance.collection('panchita/001/clientes').getDocuments();
       clientes = documentos.documents.map((d)=>Cliente.map(d)).toList();
       return clientes;
}


Stream<DocumentReference> setCliente(Cliente cliente){
   
return Firestore.instance.collection('panchita/001/clientes').add({
"nombre"    : cliente.nombre,
"cedula"    : cliente.cedula,
"direccion" : cliente.direcion,
"select"    : cliente.select
}).asStream();

}
       


}
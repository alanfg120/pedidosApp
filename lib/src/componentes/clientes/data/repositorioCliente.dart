
import 'package:pedidos/src/componentes/clientes/models/clienteClass.dart';
import 'package:pedidos/src/plugins/fireBase.dart';

class ClientesRepositorio {
  final String colletion = 'panchita/001/clientes';

  Future<List<Cliente>> getClientes() async {
  
    final documentos = await getDocument(colletion,'');
    return documentos.documents.map((d) => Cliente.map(d)).toList();

  }
  Stream setCliente(Cliente cliente) => addDocument(colletion, cliente.id, {
        "nombre"    : cliente.nombre,
        "cedula"    : cliente.cedula,
        "direccion" : cliente.direcion,
        "select"    : cliente.select
      });
  Stream updateCliente(Cliente cliente) => updateDocument(colletion, cliente.id, {
        "nombre"    : cliente.nombre,
        "cedula"    : cliente.cedula,
        "direccion" : cliente.direcion,
        "select"    : cliente.select
      });


}

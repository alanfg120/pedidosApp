import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pedidos/src/componentes/pedidos/models/pedidosClass.dart';
import 'package:pedidos/src/componentes/productos/models/productosClass.dart';
import 'package:pedidos/src/plugins/formato.dart';

class DetallesPedidoPage extends StatefulWidget {

  final Pedido pedido;

  DetallesPedidoPage({Key key,this.pedido}) : super(key: key);

  @override
  _DetallesPedidoPageState createState() => _DetallesPedidoPageState();
}

class _DetallesPedidoPageState extends State<DetallesPedidoPage> {
  
   final Color primaryColor = Colors.teal;
  @override
  Widget build(BuildContext context) {
  
                    
                     return Scaffold(
                            appBar : AppBar(
                                     title: Text("Detalles del Pedido"),
                                     iconTheme: IconThemeData(color:primaryColor),
                                    ),
                            body   : Column(
                                     children: <Widget>[
                                              ListTile(
                                              title    : Text(widget.pedido.cliente.nombre),
                                              subtitle : Text("Nombre"),
                                              leading  : Icon(MaterialCommunityIcons.account_outline),
                                              ),
                                              ListTile(
                                              title    : Text(widget.pedido.cliente.cedula),
                                              subtitle : Text("Cedula"),
                                              leading  : Icon(MaterialCommunityIcons.id_card),
                                              ),
                                              ListTile(
                                              title    : Text(widget.pedido.cliente.direcion),
                                              subtitle : Text("Direccion"),
                                              leading  : Icon(MaterialCommunityIcons.map_check),
                                              ),
                                              ListTile(
                                              leading  : Text("No"),
                                              title    : Text("Productos"),
                                              trailing : Text("Cantidad"),
                                              ),
                                              Expanded(
                                              child: listaProductos(widget.pedido.productos)
                                              ),
                                              SafeArea(
                                              child: ListTile(
                                                     title    : Text(
                                                                "Total",
                                                                style: TextStyle(
                                                                       fontSize   : 20,
                                                                       fontWeight : FontWeight.bold
                                                                       )
                                                                ),
                                                     leading  : Icon(MaterialCommunityIcons.currency_usd),
                                                     trailing : Text(
                                                                formatoMoney(widget.pedido.total),
                                                                style: TextStyle(fontWeight: FontWeight.bold)
                                                                ),
                                              ),
                                            ),
                                  ],
                                )
                             
                          
                                         
                     );

          
  
  }

  listaProductos(List<Producto> productos) {

    return ListView.separated(
           separatorBuilder: (context,i)=>Divider(height: 1),
           itemCount: productos.length,
           itemBuilder: (context,i){
                        return ListTile(
                               title: Text(productos[i].productoNombre),
                               subtitle: Text(formatoMoney(productos[i].precio)),
                               leading: Text('${i+1}'),
                               trailing: Text(productos[i].cantidad.toString()),
                        );
           },
    );
  }


}
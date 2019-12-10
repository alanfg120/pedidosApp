import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedidos/src/componentes/productos/blocs/productoBloc/productoBloc.dart';
import 'package:pedidos/src/componentes/productos/blocs/productoBloc/productoState.dart';
import 'package:pedidos/src/componentes/productos/models/productosClass.dart';


class ProductosPage extends StatefulWidget {
  ProductosPage({Key key}) : super(key: key);

  @override
  _ProductosPageState createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {
  @override
  Widget build(BuildContext context) {
     

                    return Scaffold(
                           appBar: AppBar(
                                   centerTitle : false,
                                   title       : Text(
                                                 "Productos",
                                                  style: TextStyle(
                                                         color      : Colors.teal,
                                                         fontSize   : 35.0,
                                                         fontWeight : FontWeight.w300,
                                                         fontFamily : "Alata"
                                                         )
                                               ),
                                   actions : <Widget>[
                                              IconButton(
                                                icon      : Icon(
                                                             Icons.search,
                                                             color : Colors.teal,
                                                             size  : 30.0,
                                                            ),
                                                onPressed : (){},
                                              )
                                  ],
                           ),
                           body: BlocBuilder<ProductosBloc,ProductosState>( 
                                 builder: (context,state){
                                   if(state is LoadingProductos)
                                   return Center(child: CircularProgressIndicator());
                                   if(state is LoadedProductos)
                                   return listaProductos(state.productos);
                                   return Container();
                                 } 
                           )
                    );
          }

  Widget listaProductos(List<Producto>producto) {

 
    return ListView.builder(
      itemCount: producto.length,
      itemBuilder: (context,i){
                    return ListTile(
                                  title: Text(producto[producto.length-(i+1)].productoNombre),
                                  leading: Text(producto[producto.length-(i+1)].select.toString()),
                                   );
      },
    );
  }
  
  }

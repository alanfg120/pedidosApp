
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pedidos/src/componentes/productos/blocs/bloc.dart';
import 'package:pedidos/src/componentes/productos/models/productosClass.dart';
import 'package:pedidos/src/componentes/productos/vistas/searchProductos.dart';
import 'package:pedidos/src/plugins/formato.dart';


class ProductosPage extends StatefulWidget {
  ProductosPage({Key key}) : super(key: key);

  @override
  _ProductosPageState createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {

  final scafold = GlobalKey<ScaffoldState>();
  Color primaryColor = Colors.pinkAccent;
  @override
  Widget build(BuildContext context) {
     
              return BlocBuilder<ProductosBloc,ProductosState>(
                             builder: (context,state)=>
                             Scaffold(
                             key:  scafold,
                             appBar: AppBar(
                                     centerTitle : false,
                                     title       : Row(
                                                   children: <Widget>[
                                                      Icon(FontAwesome5.list_alt,size:32,color:primaryColor),
                                                      SizedBox(width: 20),
                                                      Text("Productos",style:TextStyle(color:primaryColor))
                                                   ],
                                     ),
                                     actions : <Widget>[
                                                IconButton(
                                                  icon      : Icon(
                                                               EvilIcons.search,
                                                               color : primaryColor,
                                                               size  : 30.0,
                                                              ),
                                                  onPressed : (){
                                                    if(state is LoadedProductos)
                                                     Navigator.push(
                                                             context, MaterialPageRoute(
                                                                      builder: (context)=>SearchProductoPage(productos: state.productos))); 
                                                  },
                                                )
                                    ],
                             ),
                             body: BlocListener<ProductosBloc,ProductosState>(
                                   listener: (context,state){
                                    
                                   },
                                   child: BlocBuilder<ProductosBloc,ProductosState>( 
                                     builder: (context,state){

                                       if(state is LoadingProductos)
                                          return Center(child: CircularProgressIndicator());
                                       if(state is LoadedProductos)
                                          return Column(
                                                children: <Widget>[
                                                          ListTile(
                                                          trailing : Text("Precio"),
                                                          title    : Text("Nombre del Producto"),
                                                          leading  : Icon(MaterialCommunityIcons.cloud_upload_outline),
                                                          ),
                                                          Expanded(
                                                          child: listaProductos(state.productos)
                                                          )
                                                ],
                                          );

                                       //return listaProductos(state.productos);
                                       return Container();
                                     } 
                               ),
                             )
                      ),
              );
          }

  Widget listaProductos(List<Producto>producto) {
    
    final listproductos = producto.reversed.toList();
    if(producto.isEmpty) return Center(child: Text("No hay Productos Guardados"));
    return ListView.separated(
       
      separatorBuilder: (context,i)=>Divider(height: 1),
      itemCount: producto.length,
      itemBuilder: (context,i){
                    return Slidable(
                           secondaryActions: <Widget>[
                                                IconSlideAction(
                                                caption : 'Editar',
                                                color   : primaryColor,
                                                icon    : Icons.edit,
                                                onTap:  ()=> setState((){
                                                             BlocProvider.of<FormProductoBloc>(context).add(UpdateproductoForm(listproductos[i]));
                                                             Navigator.pushNamed(context, 'formproducto');  
                                                            })
                                                )
                                                ],
                           actionPane : SlidableDrawerActionPane(),
                           child: ListTile(
                                    leading  : !listproductos[i].sincronizado
                                               ? Icon(EvilIcons.check,color:primaryColor)
                                               : SizedBox(
                                                 height: 20,
                                                 width:  20,
                                                 child: CircularProgressIndicator(
                                                   strokeWidth: 2,
                                                   valueColor: AlwaysStoppedAnimation(
                                                     primaryColor
                                                   ),
                                                 ),
                                               ),
                                    title    : Text(listproductos[i].productoNombre),
                                    subtitle : Text(listproductos[i].codigo),
                                    trailing : Text(
                                                //listproductos[i].id,
                                                formatoMoney(listproductos[i].precio),
                                                style: TextStyle(fontWeight: FontWeight.bold)
                                               ),
                          ),
                    );
      },
    );
  }
  
  }

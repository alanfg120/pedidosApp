

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/formpedidoBloc/formpedidoBloc.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/formpedidoBloc/formpedidoEvent.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/pedidosBloc/pedidosBloc.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/pedidosBloc/pedidosState.dart';
import 'package:pedidos/src/componentes/pedidos/models/pedidosClass.dart';
import 'package:pedidos/src/componentes/pedidos/vistas/detallesPage.dart';
import 'package:pedidos/src/plugins/formato.dart';


class PedidosPage extends StatefulWidget {

  PedidosPage({Key key}) : super(key: key);
  @override
  _PedidosPageState createState() => _PedidosPageState();

  
}

class _PedidosPageState extends State<PedidosPage> {
   
  Color primaryColor= Colors.teal;


  @override
  Widget build(BuildContext context) {
      //ignore: close_sinks
  
    
     return Scaffold(
             appBar : AppBar(
                     centerTitle : false,
                     title       : Row(
                                   children: <Widget>[
                                             Icon(EvilIcons.cart,size: 40,color: primaryColor),
                                             SizedBox(width: 20),
                                             Text("Pedidos",style: TextStyle(color: primaryColor))
                                             ],
                     ),
                     actions     : <Widget>[
                                            IconButton(
                                            onPressed : (){},
                                            icon      : Icon(
                                                        EvilIcons.search,
                                                        color : primaryColor,
                                                        size  : 30.0,
                                                        )
                                             )
                                       ],
                    elevation: 1,
           ),
           body   : BlocBuilder<PedidosBloc,PedidosState>(
                    builder: (context,state){
                               if(state is LoadingPedidos)
                                 return Center(child: CircularProgressIndicator());
                               if(state is LoadedPedidos){
                                return Column(
                                  children: <Widget>[
                                    ListTile(
                                    trailing: Text("Total Pedido"),
                                    title: Text("Nombre del Cliente"),
                                    leading: Icon(MaterialCommunityIcons.cloud_upload_outline),
                                    ),
                                    Expanded(
                                    child: listaPedidos(state.pedidos)
                                    )
                                  ],
                                );
                                //return  listaPedidos(state.pedidos);
                               }
                                 return Container();
                    },
           ),
     );
  }

  Widget listaPedidos(List<Pedido> pedidos){
           final listpedidos = pedidos.reversed.toList();
  
           if(pedidos.isEmpty) return Center(child: Text("No hay Pedidos Guardados"));
           return  ListView.separated(
                   separatorBuilder : (context,i) => Divider(height: 1),
                   itemCount        : listpedidos.length,
                   itemBuilder      : (context,i){
                                        return Slidable(
                                                secondaryActions: <Widget>[
                                                                       IconSlideAction(
                                                                       caption : 'Editar',
                                                                       color   : primaryColor,
                                                                       icon    : Icons.edit,
                                                                       onTap:  (){
                                                                                BlocProvider.of<FormPedidosBloc>(context).add(UpdatePedidoForm(listpedidos[i]));
                                                                                Navigator.pushReplacementNamed(context,'formpedidos');
                                                                          
                                                                               }
                                                                       )
                                                                       ],
                                               actionPane : SlidableDrawerActionPane(),
                                               child: ListTile(
                                                      title    : Text(listpedidos[i].cliente.nombre),
                                                      subtitle : Text(formatoDate(listpedidos[i].fecha.toString())),
                                                      trailing : Text(
                                                                 //listpedidos[i].id,
                                                                 formatoMoney(listpedidos[i].total),
                                                                 style: TextStyle(fontWeight: FontWeight.bold),
                                                                 ),
                                                      leading  : !listpedidos[i].sincronizado
                                                                 ? Icon(EvilIcons.check,color:primaryColor)
                                                                 : SizedBox(
                                                                   height : 20,
                                                                   width  : 20,
                                                                   child  : CircularProgressIndicator(
                                                                            strokeWidth : 2,
                                                                            valueColor  : AlwaysStoppedAnimation(primaryColor),
                                                                   ),
                                                                 ),
                                                      onTap: (){
                                                        Navigator.push(
                                                        context, MaterialPageRoute(
                                                                 builder: (context)=>DetallesPedidoPage(pedido: listpedidos[i])));
                                                      },
                                               ),
                                        );
                    },
             
           );
  }
}
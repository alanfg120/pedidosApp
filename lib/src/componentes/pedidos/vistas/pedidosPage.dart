import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/pedidosBloc/pedidosBloc.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/pedidosBloc/pedidosState.dart';


class PedidosPage extends StatefulWidget {
  PedidosPage({Key key}) : super(key: key);
  @override
  _PedidosPageState createState() => _PedidosPageState();
}

class _PedidosPageState extends State<PedidosPage> {
  
  @override
  Widget build(BuildContext context) {
     return Scaffold(
            appBar : AppBar(
                     centerTitle : false,
                     title       : Text("Pedidos"),
                     actions     : <Widget>[
                                            IconButton(
                                            onPressed : (){},
                                            icon      : Icon(
                                                        Icons.search,
                                                        color : Colors.teal,
                                                        size  : 30.0,
                                                        )
                                             )
                                       ],
           ),
           body   : BlocBuilder<PedidosBloc,PedidosState>(
                    builder: (context,state){
                               if(state is LoadingPedidos)
                                 return Center(child: CircularProgressIndicator());
                               if(state is LoadedPedidos){
                                 return  listaPedidos(state.pedidos);
                               }
                                 return Container();
                    },
           ),
     );
  }

  Widget listaPedidos(pedidos){
           return ListView.builder(
                  itemCount   : pedidos.length,
                  itemBuilder : (context,i){
                                   return ListTile(
                                          title: Text(pedidos[pedidos.length-(i+1)].nombreCliente),
                                   );
                  },
           );
  }
}
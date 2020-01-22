import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pedidos/src/componentes/clientes/blocs/bloc.dart';
import 'package:pedidos/src/componentes/clientes/models/clienteClass.dart';
import 'package:pedidos/src/componentes/clientes/vistas/searchCliente.dart';

class ClientesPage extends StatefulWidget {
  ClientesPage({Key key}) : super(key: key);

  @override
  _ClientesPageState createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {
  
   Color primaryColor = Colors.purple;

  @override
  Widget build(BuildContext context) {


    return BlocBuilder<ClientesBloc,ClientesState>(
          builder:(context,state)=>
          Scaffold(
          appBar: AppBar(
                  centerTitle : false,
                  title       : Row(
                                children: <Widget>[
                                  Icon(FontAwesome5.user,size:30,color: primaryColor),
                                  SizedBox(width: 20),
                                  Text("Clientes",style:TextStyle(color: primaryColor))
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
                                  if(state is LoadedClientes)
                                  Navigator.push(
                                  context, MaterialPageRoute(
                                           builder: (context)=>SearchClientesPage(clientes:state.clientes))); 
                                },
                              )
                  ],
         ),
         body: BlocBuilder<ClientesBloc,ClientesState>(
               builder: (context,state){
                  if(state is LoadingClientes)
                  return  CircularProgressIndicator();
                  if (state is LoadedClientes)
                   return Column(
                          children: <Widget>[
                                    ListTile(
                                    trailing : Text("Cedula"),
                                    title    : Text("Nombre del Cliente"),
                                    leading  : Icon(MaterialCommunityIcons.cloud_upload_outline),
                                    ),
                                    Expanded(
                                    child: listadeClientes(state.clientes)
                                    )
                          ],
                   );
                  return Container();
               }

         )
      ),
    );
  }

  Widget listadeClientes(List<Cliente> clientes) {
     if(clientes.isEmpty) return Center(child: Text("No hay Clientes Guardados"));
      return ListView.separated(
        separatorBuilder: (context,i)=>Divider(height: 1),
        itemCount: clientes.length,
        itemBuilder: (context,i){
             return Slidable(
                    secondaryActions: <Widget>[
                                                IconSlideAction(
                                                caption : 'Editar',
                                                color   : primaryColor,
                                                icon    : Icons.edit,
                                                onTap:  ()=> setState((){
                                                             BlocProvider.of<FormClienteBloc>(context).add(UpdateCliente(clientes[i]));
                                                             Navigator.pushNamed(context, 'formcliente');  
                                                            })
                                                )
                                                ],
                    actionPane : SlidableDrawerActionPane(),
                    child: ListTile(
                           title    : Text("${clientes[i].nombre}"),
                           subtitle : Text("${clientes[i].direcion}"),
                           trailing : Text("${clientes[i].cedula}"), 
                           leading  : !clientes[i].sincronizado
                                      ? Icon(EvilIcons.check,color:primaryColor)
                                      : SizedBox(
                                        height : 20,
                                        width  : 20,
                                        child  : CircularProgressIndicator(
                                                 strokeWidth : 2,
                                                 valueColor  : AlwaysStoppedAnimation(primaryColor),
                                        ),
                         ),
                         ),
             );

        },
      );

  }
}
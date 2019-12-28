import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pedidos/src/componentes/clientes/blocs/clientesBloc.dart/clientesBloc.dart';
import 'package:pedidos/src/componentes/clientes/blocs/clientesBloc.dart/clientesState.dart';
import 'package:pedidos/src/componentes/clientes/models/clienteClass.dart';

class ClientesPage extends StatefulWidget {
  ClientesPage({Key key}) : super(key: key);

  @override
  _ClientesPageState createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {
  
   Color primaryColor = Colors.purple;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              onPressed : (){},
                            )
                ],
       ),
       body: BlocBuilder<ClientesBloc,ClientesState>(
             builder: (context,state){
                if(state is LoadingClientes)
                return  CircularProgressIndicator();
                if (state is LoadedClientes)
                return listadeClientes(state.clientes);
                return Container();
             }

       )
    );
  }

  Widget listadeClientes(List<Cliente> clientes) {

      return ListView.separated(
        separatorBuilder: (context,i)=>Divider(height: 1),
        itemCount: clientes.length,
        itemBuilder: (context,i){
             return ListTile(
               title: Text("${clientes[i].nombre}"),
               leading: Icon(EvilIcons.check,color: primaryColor),
             );

        },
      );

  }
}
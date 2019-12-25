import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedidos/src/componentes/clientes/blocs/clientesBloc.dart/clientesBloc.dart';
import 'package:pedidos/src/componentes/clientes/blocs/clientesBloc.dart/clientesState.dart';
import 'package:pedidos/src/componentes/clientes/models/clienteClass.dart';

class ClientesPage extends StatefulWidget {
  ClientesPage({Key key}) : super(key: key);

  @override
  _ClientesPageState createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
                centerTitle : false,
                title       : Text("Clientes"),
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

      return ListView.builder(
        itemCount: clientes.length,
        itemBuilder: (context,i){
             return ListTile(
               title: Text("${clientes[i].nombre}"),
               trailing: Text("${clientes[i].select}"),
             );

        },
      );

  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pedidos/src/componentes/clientes/blocs/bloc.dart';
import 'package:pedidos/src/componentes/clientes/data/repositorioCliente.dart';
import 'package:pedidos/src/componentes/clientes/models/clienteClass.dart';

class SearchClientesPage extends StatefulWidget {
  final List<Cliente> clientes;

  SearchClientesPage({Key key,this.clientes}) : super(key: key);

  @override
  _SearchClientesPageState createState() => _SearchClientesPageState();
}

class _SearchClientesPageState extends State<SearchClientesPage> {

 
  @override
  void initState() {
     
   bloc.add(SearchClientesEvent(query:'',clientes: widget.clientes));
   super.initState();
  }
  final bloc = ClientesBloc(repo: ClientesRepositorio());
  Color primaryColor = Colors.purple;
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
        appBar: AppBar(
                title: TextField(
                       style      : TextStyle(fontSize: 20),
                       controller : controller,
                       autofocus  : true,
                       decoration : InputDecoration(
                                    hintText: "Buscar Cliente",
                                    hintStyle: TextStyle(fontSize: 20),
                                    border: InputBorder.none
                                    ),
                       onChanged: (value) {
                        bloc.add(SearchClientesEvent(query:value,clientes: widget.clientes));
                       } ,
                        ),
                actions: <Widget>[
                          IconButton(
                          icon      : Icon(
                                      Icons.cancel,
                                      color: Colors.grey,
                                      ),
                          onPressed : () {
                                         controller.clear();
                                         
                                         },
                          )
                          ],
          iconTheme: IconThemeData(color: primaryColor),
        ),
          body: BlocBuilder<ClientesBloc,ClientesState>(
                 bloc: bloc,
                 builder: (context, state) {
                   return resutlSearch(context, state);
                 },
        ));
  }

  Widget resutlSearch(BuildContext context, ClientesState state) {
    if(state is LoadedClientes)
       if(state.clientes.isNotEmpty)
    return ListView.builder(
      itemCount: state.clientes.length,
      itemBuilder: (BuildContext context, int i) {
                    return  Slidable(
                            secondaryActions: <Widget>[
                                                   IconSlideAction(
                                                   caption : 'Editar',
                                                   color   : primaryColor,
                                                   icon    : Icons.edit,
                                                   onTap:  (){
                                                           BlocProvider.of<FormClienteBloc>(context).add(UpdateCliente(state.clientes[i]));
                                                           Navigator.pushNamed(context, 'formcliente');  
                                                      
                                                          }
                                                   )
                                                   ],
                           actionPane : SlidableDrawerActionPane(),
                           child: ListTile(
                                  title    : Text(state.clientes[i].nombre),
                                  subtitle : Text(state.clientes[i].direcion),
                                  trailing : Text(state.clientes[i].cedula),
                                  leading  : !state.clientes[i].sincronizado
                                             ? Icon(EvilIcons.check,color:primaryColor)
                                             : SizedBox(
                                               height : 20,
                                               width  : 20,
                                               child  : CircularProgressIndicator(
                                                        strokeWidth : 2,
                                                        valueColor  : AlwaysStoppedAnimation(primaryColor),
                                               ),
                                             )
                                 
                           ),
                                        );
     },
    );
    return Center(child:Text("Sin Resultados"));
  }
}

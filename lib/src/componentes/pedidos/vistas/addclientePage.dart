import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedidos/src/componentes/clientes/data/repositorioCliente.dart';
import 'package:pedidos/src/componentes/clientes/models/clienteClass.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/bloc.dart';



class AddClientePage extends StatefulWidget {
  AddClientePage({Key key}) : super(key: key);

  @override
  _AddClientePageState createState() => _AddClientePageState();
}

class _AddClientePageState extends State<AddClientePage> {
  
   bool select = false;
   final controller = TextEditingController();  
   ClientesRepositorio repo =  ClientesRepositorio();
   Color primaryColor  = Colors.teal;
  @override
 Widget build(BuildContext context) {
    
    //ignore: close_sinks
     final formpedidoBloc = BlocProvider.of<FormPedidosBloc>(context);
     return  Scaffold(
             appBar: AppBar(
                                title: TextField(
                                       style: TextStyle(fontSize: 20),
                                       controller: controller,
                                       autofocus  : true,
                                       decoration : InputDecoration(
                                                    hintText  : "Buscar Cliente",
                                                    hintStyle : TextStyle(fontSize: 20),
                                                    border    : InputBorder.none
                                                   ),
                                       onChanged  : (value){
                                                      formpedidoBloc.add(SearchEvent(value,'clientes'));
                                                    },
                                ),
                                actions: <Widget>[
                                         IconButton(
                                         icon      : Icon(Icons.cancel,color: Colors.grey,),
                                         onPressed : (){
                                                        controller.clear();
                                                        formpedidoBloc.add(SearchEvent('','clientes'));
                                                       },
                                         )
                                ],
                                iconTheme: IconThemeData(color: primaryColor),
                               ),
                             body: BlocBuilder<FormPedidosBloc,FormPedidoState>(
                                   builder: (context,state){
                                   return resutlSearch(context,state,formpedidoBloc);
                                   },
                             )
                       
                 );
       
             }

 Widget resutlSearch(BuildContext context,FormPedidoState state,bloc) {
                    if(state.query.isEmpty){
                        return Column(
                               children: <Widget>[
                                            Flexible(
                                              flex: 2,
                                              child: ListTile(
                                                     leading : Icon(Icons.add,color: Colors.green),
                                                     title   : Text("Nuevo Cliente"),
                                                     onTap   : ()=> Navigator.pushNamed(context, 'formcliente')
                                                    ),
                                            ),
                                            Divider(),
                                            Flexible(
                                              flex: 2,
                                              child: Padding(
                                                     padding: EdgeInsets.symmetric(vertical: 10),
                                                     child: Text("Todos los Clientes",style: TextStyle(fontSize: 25),)
                                                     ),
                                            ),
                                            Flexible(
                                              flex: 8,
                                              child:  listaClientes(state.clientes, bloc),
                                            )
                                            
                                    
                                         ],
                               );
           
                    }
                   
                   return listaClientes(state.clientes,bloc);
                      
           
 
}

 Widget listaClientes(List<Cliente> clientes,bloc) {
        return ListView.builder(
              itemCount: clientes.length,
              itemBuilder: (context,i){
                        
                         return  ListTile(
                                  title: Text(clientes[i].nombre),
                                  trailing:RaisedButton(
                                    color: primaryColor,
                                    child: Text("Agregar",style: TextStyle(color: Colors.white)),
                                    onPressed: (){
                                      bloc.add(AddCliente(cliente:clientes[i]));
                                      Navigator.pop(context);
                                    }
                                  )
                                
                           );
              },          
        );
  }



}

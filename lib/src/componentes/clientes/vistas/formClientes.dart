import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedidos/src/componentes/clientes/blocs/clientesBloc.dart/clientesBloc.dart';
import 'package:pedidos/src/componentes/clientes/blocs/clientesBloc.dart/clientesEvent.dart';
import 'package:pedidos/src/componentes/clientes/blocs/formclientBloc.dart/formclienteEvent.dart';
import 'package:pedidos/src/componentes/clientes/blocs/formclientBloc.dart/formclienteState.dart';
import 'package:pedidos/src/componentes/clientes/blocs/formclientBloc.dart/formclientesBloc.dart';
import 'package:pedidos/src/componentes/clientes/models/clienteClass.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/formpedidoBloc/formpedidoBloc.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/formpedidoBloc/formpedidoEvent.dart';
import 'package:pedidos/src/componentes/pedidos/data/repositorioPedidos.dart';

class FormCliente extends StatefulWidget {
  
  FormCliente({Key key}) : super(key: key);
  @override
  _FormClienteState createState() => _FormClienteState();
}

class _FormClienteState extends State<FormCliente> {

  final _clientes      = GlobalKey<FormState>();
  final _scafold      = GlobalKey<ScaffoldState>();
  final _fococliente  = FocusNode();
  final _fococedula   = FocusNode();
  final _focodirecion = FocusNode();

  PedidosRepositorio repo = PedidosRepositorio();

  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final formclienteBloc = BlocProvider.of<FormClienteBloc>(context);
    //ignore: close_sinks
    final clientesBloc    = BlocProvider.of<ClientesBloc>(context);
     //ignore: close_sinks
    final formpedidoBloc = BlocProvider.of<FormPedidosBloc>(context);
    return BlocBuilder<FormClienteBloc, FormClienteState>(
           builder: (context, state) {
              return Scaffold(
                             key    : _scafold,
                             appBar : AppBar(title: Text("Agregar Cliente")),
                             body   : GestureDetector(
                                      onTap : () => FocusScope.of(context).unfocus(),
                                      child : SingleChildScrollView(
                                              child: Form(
                                                     key     : _clientes,
                                                     child   : Container(
                                                     padding : EdgeInsets.symmetric(
                                                               vertical   : 30, 
                                                               horizontal : 20
                                                               ),
                                                     child   : Column(
                                                               children: <Widget>[
                                                                          input("Cliente", _fococliente, Icon(Icons.person), state.cliente),
                                                                          SizedBox(height: 20),
                                                                          input("Cedula", _fococedula, Icon(Icons.credit_card), state.cliente),
                                                                          SizedBox(height: 20),
                                                                          input("Direccion", _focodirecion, Icon(Icons.map), state.cliente),
                                                                          SizedBox(height: 20),
                                                                          
                                                                       ],
                                                                ),
                                                      ),
                                              ),
                                      ),
                              ),
                         floatingActionButton: addclienteButton(formclienteBloc,clientesBloc,formpedidoBloc,state)
      );
    
    }
    
    );
  }

  Widget input(String text, FocusNode foco, Icon icono, Cliente state) {

         TextInputAction textinput;
         text == 'Direccion' ? textinput = TextInputAction.newline 
                             : textinput = TextInputAction.next;
         return TextFormField(
               validator       : (value) => value.isEmpty ? "Requerido": null,
               focusNode       : foco,
               textInputAction : textinput,
               decoration      : inputDecorador(icono, text),
               initialValue    : initialValue(text, state),
               style           : TextStyle(color: Colors.teal, fontSize: 23.0),
               cursorColor     : Colors.teal,
               onChanged       : (value){
                                          switch (text) {
                                            case "Cliente"   : state.nombre= value;
                                                               break;
                                            case "Cedula"    : state.cedula = value; 
                                                               break;
                                            case "Direccion" : state.direcion = value;
                                                               break;
                                            default          : break;
                                          }
                                        },
              onEditingComplete : (){
                                     switch (text) {
                                       case 'Cliente' : FocusScope.of(context).requestFocus(_fococedula);
                                                        break;
                                       case 'Cedula'  : FocusScope.of(context).requestFocus(_focodirecion); 
                                                        break;
                                       default        : break;
                                     }
                                    },
          
    );
  }

  
  String initialValue(String text, state) {
         switch (text) {
           case "Cliente"   : return state.nombre;
                              break;
           case "Cedula"    : return state.cedula;
                              break;
           case "Direccion" : return state.direcion;
                              break;
           default          : break;
         }
         return null;
  }   

  

  Widget addclienteButton(FormClienteBloc formclienteBloc,ClientesBloc clientesBloc,formpedidoBloc,FormClienteState state){
         return FloatingActionButton( 
                child     : Icon(Icons.check),
                onPressed : () {
                               if (_clientes.currentState.validate()){
                                  
                                    formclienteBloc.add(AddclienteForm(state.cliente));
                                    formpedidoBloc.add(UpdateClienteForm(state.cliente));
                                    clientesBloc.add(UpdateClientes(state.cliente));
                                    
                                    
                                    Navigator.pop(context);
                               }
                              },
        );
  } 
  InputDecoration inputDecorador(icono,text){
     return InputDecoration(
            hintStyle      : TextStyle(color: Colors.teal, fontSize: 15.0),
            icon           : icono,
            contentPadding : EdgeInsets.all(5),
            errorStyle     : TextStyle(color: Colors.red),
            hintText       : text,
            focusedBorder  : OutlineInputBorder(
                             borderSide: BorderSide(
                                         color : Colors.teal, 
                                         style : BorderStyle.solid, 
                                         width : 2.0
                                         )
                            ),
            enabledBorder  : OutlineInputBorder(
                             borderSide : BorderSide(
                                          color : Colors.teal, 
                                          style : BorderStyle.solid, 
                                          width : 2.0
                                          )
                            ),
        //prefixIcon : icono,
      );
  }


}

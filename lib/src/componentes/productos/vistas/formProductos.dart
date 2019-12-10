import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/formpedidoBloc/formpedidoBloc.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/formpedidoBloc/formpedidoEvent.dart';
import 'package:pedidos/src/componentes/pedidos/data/repositorioPedidos.dart';
import 'package:pedidos/src/componentes/productos/blocs/formproductoBloc/formproductoBloc.dart';
import 'package:pedidos/src/componentes/productos/blocs/formproductoBloc/formproductoEvent.dart';
import 'package:pedidos/src/componentes/productos/blocs/formproductoBloc/formproductoState.dart';
import 'package:pedidos/src/componentes/productos/blocs/productoBloc/productoBloc.dart';
import 'package:pedidos/src/componentes/productos/blocs/productoBloc/productoEvent.dart';
import 'package:pedidos/src/componentes/productos/models/productosClass.dart';

class FormProductos extends StatefulWidget {
  
  FormProductos({Key key}) : super(key: key);
  @override
  _FormProductosState createState() => _FormProductosState();
}

class _FormProductosState extends State<FormProductos> {

  final _productos      = GlobalKey<FormState>();
  final _scafold      = GlobalKey<ScaffoldState>();
  final _fococodigo  = FocusNode();
  final _foconombre  = FocusNode();
  final _focoprecio = FocusNode();

  PedidosRepositorio repo = PedidosRepositorio();

  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final formproductobloc = BlocProvider.of<FormProductoBloc>(context);
    //ignore: close_sinks
    final productoBloc = BlocProvider.of<ProductosBloc>(context);
    //ignore: close_sinks
    final formpedidoBloc = BlocProvider.of<FormPedidosBloc>(context);
    return BlocBuilder<FormProductoBloc, FormProductoState>(
           builder: (context, state) {
                      return Scaffold(
                             key    : _scafold,
                             appBar : AppBar(title: Text("Agregar Producto")),
                             body   : GestureDetector(
                                      onTap : () => FocusScope.of(context).unfocus(),
                                      child : SingleChildScrollView(
                                              child: Form(
                                                     key     : _productos,
                                                     child   : Container(
                                                     padding : EdgeInsets.symmetric(
                                                               vertical   : 40, 
                                                               horizontal : 20
                                                               ),
                                                     child   : Column(
                                                               children: <Widget>[
                                                                          input("Codigo", _fococodigo, Icon(Icons.person), state.producto),
                                                                          SizedBox(height: 20),
                                                                          input("Nombre", _foconombre, Icon(Icons.credit_card), state.producto),
                                                                          SizedBox(height: 20),
                                                                          input("Precio", _focoprecio, Icon(Icons.map), state.producto),
                                                                          SizedBox(height: 20),
                                                                         
                                                                       
                                                                       ],
                                                                ),
                                                      ),
                                              ),
                                      ),
                              ),
                         floatingActionButton: addpedidoButton(formproductobloc,productoBloc,formpedidoBloc,state)
      );
    
    }
    
    );
  }

  Widget input(String text, FocusNode foco, Icon icono, Producto state) {

         TextInputAction textinput;
         text == 'Precio'    ? textinput = TextInputAction.done 
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
                                            case "Codicgo"   : state.codigo = value;
                                                               break;
                                            case "Nombre"    : state.productoNombre = value; 
                                                               break;
                                            case "Precio"    : state.precio = double.parse(value);
                                                               break;
                                            default          : break;
                                          }
                                        },
              onEditingComplete : (){
                                     switch (text) {
                                       case 'Cliente' : FocusScope.of(context).requestFocus(_foconombre);
                                                        break;
                                       case 'Cedula'  : FocusScope.of(context).requestFocus(_focoprecio); 
                                                        break;
                                       default        : break;
                                     }
                                    },
          
    );
  }

 

  String initialValue(String text,Producto state) {
         switch (text) {
           case "Codigo"   : return state.codigo;
                              break;
           case "Nombre"    : return state.productoNombre;
                              break;
           case "Precio"    : return state.precio.toString();
                              break;
           default          : break;
         }
         return null;
  }   

  

  Widget addpedidoButton(formpedidoBloc,productoBloc,fpedidobloc,FormProductoState state){
         return FloatingActionButton( 
                child     : Icon(Icons.check),
                onPressed : () {
                               if (_productos.currentState.validate()){
                                    formpedidoBloc.add(AddproductoForm(state.producto));
                                    productoBloc.add(UpdateProductos(state.producto));
                                    fpedidobloc.add(UpdateProductoForm(state.producto));
                                    Navigator.pop(context);
                               }
                              },
        );
  } 
  InputDecoration inputDecorador(icono,text){
     return InputDecoration(
            helperText     : text=='Precio' ? "Precio" : null,
            helperStyle    : TextStyle(color: Colors.red,fontSize: 18),
            hintStyle      : TextStyle(color: Colors.teal, fontSize: 20.0),
            icon           : icono,
            contentPadding : EdgeInsets.all(10),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/formpedidoBloc/formpedidoBloc.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/formpedidoBloc/formpedidoEvent.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/formpedidoBloc/formpedidoState.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/pedidosBloc/pedidosBloc.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/pedidosBloc/pedidosEvent.dart';
import 'package:pedidos/src/componentes/pedidos/data/repositorioPedidos.dart';
import 'package:pedidos/src/componentes/productos/models/productosClass.dart';

class FormPedidos extends StatefulWidget {
  
  FormPedidos({Key key}) : super(key: key);
  @override
  _FormPedidosState createState() => _FormPedidosState();
}

class _FormPedidosState extends State<FormPedidos> {

  final _pedidos      = GlobalKey<FormState>();
  final _scafold      = GlobalKey<ScaffoldState>();
  final _fococliente  = FocusNode();
  final _fococedula   = FocusNode();
  final _focodirecion = FocusNode();

  PedidosRepositorio repo = PedidosRepositorio();

  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final formpedidoBloc = BlocProvider.of<FormPedidosBloc>(context);
    //ignore: close_sinks
    final pedidoBloc = BlocProvider.of<PedidosBloc>(context);
    return BlocBuilder<FormPedidosBloc, FormPedidoState>(
           builder: (context, state) {
              return Scaffold(
                             key    : _scafold,
                             appBar : AppBar(title: Text("Agregar Pedido")),
                             body   : GestureDetector(
                                      onTap : () => FocusScope.of(context).unfocus(),
                                      child : SingleChildScrollView(
                                              child: Form(
                                                     key     : _pedidos,
                                                     child   : Container(
                                                     padding : EdgeInsets.symmetric(
                                                               vertical   : 40, 
                                                               horizontal : 20
                                                               ),
                                                     child   : Column(
                                                               children: <Widget>[
                                                                          input("Cliente", _fococliente, Icon(Icons.person), state.pedido),
                                                                          SizedBox(height: 20),
                                                                          input("Cedula", _fococedula, Icon(Icons.credit_card), state.pedido),
                                                                          SizedBox(height: 20),
                                                                          input("Direccion", _focodirecion, Icon(Icons.map), state.pedido),
                                                                          SizedBox(height: 20),
                                                                          Text("Productos", style: TextStyle(fontSize: 20)),
                                                                          SizedBox(height: 10),
                                                                          addproductoBotton(context,formpedidoBloc),
                                                                          listaProductos(state.pedido.productos, context)
                                                                       ],
                                                                ),
                                                      ),
                                              ),
                                      ),
                              ),
                         floatingActionButton: addpedidoButton(formpedidoBloc,pedidoBloc,state)
      );
    
    }
    
    );
  }

  Widget input(String text, FocusNode foco, Icon icono, state) {

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
                                            case "Cliente"   : state.nombreCliente = value;
                                                               break;
                                            case "Cedula"    : state.cedulaCliente = value; 
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

  Widget listaProductos(List<Producto> producto, context) {
         return Container(
                height      : 300,
                child       : ListView.builder(
                              itemCount   : producto.length,
                              itemBuilder : (context, i) {
                                             return Dismissible(
                                                    key        : Key(i.toString()),
                                                    background : Container(
                                                                 color : Colors.red,
                                                                 child : Text(
                                                                         "Eliminar", 
                                                                          style : TextStyle(color: Colors.white)
                                                                         ),
                                                                 ),
                                                    child      : ListTile(
                                                                 subtitle : Text(
                                                                            "Precio:${producto[i].precio}",
                                                                            style: TextStyle(color: Colors.red)),
                                                                 title    : Text(
                                                                            producto[i].productoNombre,
                                                                            style: TextStyle(fontSize: 16)
                                                                            ),
                                                                 trailing : Row(
                                                                            mainAxisSize: MainAxisSize.min,
                                                                            children: <Widget>[
                                                                                       Text("Cant",style: TextStyle(fontSize: 20)),
                                                                                       SizedBox(width: 20),
                                                                                       GestureDetector (
                                                                                         onTap: ()=>updateCantidad(context,producto,i),
                                                                                         child: CircleAvatar(
                                                                                                maxRadius       : 25,
                                                                                                child           : Text('${producto[i].cantidad}'),
                                                                                                backgroundColor : Colors.white,
                                                                                         ),
                                                                                       ),
                                                                                      
                                                                                       ],
                                                                 ),
                                                     ),
                                             );
                },
                )
         );
  }

  String initialValue(String text, state) {
         switch (text) {
           case "Cliente"   : return state.nombreCliente;
                              break;
           case "Cedula"    : return state.cedulaCliente;
                              break;
           case "Direccion" : return state.direcion;
                              break;
           default          : break;
         }
         return null;
  }   

  Widget addproductoBotton(contex,bloc){
         return  RaisedButton(
                 onPressed : (){
                  bloc.add(SearchProducto(''));
                 Navigator.pushNamed(context,'addproducto');
                 },
                   
                
                 textColor : Colors.white,
                 color     : Colors.teal,
                 child     : Text(
                             "Agregar Producto",
                              style: TextStyle(fontSize: 18),
                             ),
                 shape     : RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(15)
                             )
         );
  }  

  Widget addpedidoButton(FormPedidosBloc formpedidoBloc,pedidoBloc,state){
         return FloatingActionButton( 
                child     : Icon(Icons.check),
                onPressed : () {
                               if (_pedidos.currentState.validate()){
                                    formpedidoBloc.add(ResetProducto());
                                    formpedidoBloc.add(AddPedido(state.pedido));
                                    pedidoBloc.add(UpdatePedidos(state.pedido));
                                    
                                    Navigator.pop(context);
                               }
                              },
        );
  } 
  InputDecoration inputDecorador(icono,text){
     return InputDecoration(
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

 updateCantidad(BuildContext context, List<Producto> producto,int i) {
  showDialog(
  context: context,
  builder: (context){
            return AlertDialog(
                   title   : Text("Cantidad"),
                   content : Container(
                             child: TextFormField(
                                    autofocus: true,
                                    keyboardType: TextInputType.number,
                                    initialValue: producto[i].cantidad.toString(),
                                    onChanged: (value){producto[i].cantidad = int.parse(value);},
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(border: InputBorder.none,contentPadding:EdgeInsets.all(20)),
                             ),
                            ),
                   actions: <Widget>[
                            RaisedButton(
                            textColor: Colors.white,
                            onPressed: ()=>Navigator.pop(context),
                            child: Text("Aceptar"),
                           )
                          ]
            );                   
    }
  );



 }
}

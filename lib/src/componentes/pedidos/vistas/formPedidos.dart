import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
  final _clientecontroller = TextEditingController();
  final _cedulacontroller = TextEditingController();
  final _direccioncontroller = TextEditingController();

  PedidosRepositorio repo = PedidosRepositorio();

  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final formpedidoBloc = BlocProvider.of<FormPedidosBloc>(context);
    //ignore: close_sinks
    final pedidoBloc = BlocProvider.of<PedidosBloc>(context);
    return BlocBuilder<FormPedidosBloc, FormPedidoState>(
           builder: (context, state) {
              _clientecontroller.text = state.pedido.nombreCliente;
              _cedulacontroller.text  = state.pedido.cedula;
              _direccioncontroller.text = state.pedido.direcion;
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
                                                               vertical   : 30, 
                                                               horizontal : 20
                                                               ),
                                                     child   : Column(
                                                               children: <Widget>[
                                                                          input("Cliente", _fococliente, Icon(Icons.person), state.pedido,_clientecontroller,formpedidoBloc),
                                                                          SizedBox(height: 20),
                                                                          input("Cedula", _fococedula, Icon(Icons.credit_card), state.pedido,_cedulacontroller),
                                                                          SizedBox(height: 20),
                                                                          input("Direccion", _focodirecion, Icon(Icons.map), state.pedido,_direccioncontroller),
                                                                          SizedBox(height: 20),
                                                                          Text("Productos", style: TextStyle(fontSize: 18)),
                                                                          SizedBox(height: 10),
                                                                          addproductoBotton(context,formpedidoBloc),
                                                                          Container(
                                                                           
                                                                            padding: EdgeInsets.all(10),
                                                                            alignment: Alignment.topRight,
                                                                            child: Text("Cantidad",style: TextStyle(fontSize: 18)),
                                                                          ),
                                                                          listaProductos(state.pedido.productos, context,formpedidoBloc),
                                                                          ListTile(
                                                                          trailing : Text("${state.total(state.pedido.productos)}",style:TextStyle(
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        fontSize: 25
                                                                                                       )),
                                                                          title    : Text("Total"),

                                                                          ),
                                                                          SizedBox(height: 30)
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

Widget input(String text, FocusNode foco, Icon icono, state,controller,[bloc]) {

         TextInputAction textinput;
         text == 'Direccion' ? textinput = TextInputAction.newline 
                             : textinput = TextInputAction.next;
         return TextFormField(
               controller      : controller,
               validator       : (value) => value.isEmpty ? "Requerido": null,
               focusNode       : foco,
               textInputAction : textinput,
               decoration      : inputDecorador(icono, text,bloc),
               //initialValue    : initialValue(text, state),
               style           : TextStyle(color: Colors.teal, fontSize: 23.0),
               cursorColor     : Colors.teal,
               onChanged       : (value){
                                          switch (text) {
                                            case "Cliente"   : state.nombreCliente = value;
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

  Widget listaProductos(List<Producto> producto, context,formpedidoBloc) {
         return Container(
                height      : 250,
                child       : ListView.builder(
                              shrinkWrap: true,
                              itemCount   : producto.length,
                              itemBuilder : (context, i) {
                                             return
                                                     Slidable(
                                                     secondaryActions: <Widget>[
                                                                       IconSlideAction(
                                                                       caption : 'Eliminar',
                                                                       color   : Colors.red,
                                                                       icon    : Icons.delete,
                                                                       onTap:  ()=> setState((){
                                                                                    formpedidoBloc.add(DeleteProductoForm(i));
                                                                                   })
                                                                       )
                                                                       ],
                                                     actionPane : SlidableDrawerActionPane(),
                                                     child      : ListTile(
                                                                   subtitle : Text(
                                                                              "Precio:${producto[i].precio}",
                                                                              style: TextStyle(color: Colors.red)),
                                                                   title    : Text(
                                                                              producto[i].productoNombre,
                                                                              style: TextStyle(fontSize: 16)
                                                                              ),
                                                                   trailing : Row(
                                                                              mainAxisSize : MainAxisSize.min,
                                                                              children     : <Widget>[
                                                                                              
                                                                                              SizedBox(width: 20),
                                                                                              GestureDetector (
                                                                                                onTap: ()=> updateCantidad(context,producto,i),
                                                                                                child: CircleAvatar(
                                                                                                       maxRadius       : 25,
                                                                                                       child           : Text('${producto[i].cantidad}'),
                                                                                                       backgroundColor : Colors.white,
                                                                                                )
                                                                                              )
                                                                                              ],
                                                                   ),
                                                                  
                                                       ),
                                                     );
                                            
                },
                )
         );
  }
 

  Widget addproductoBotton(contex,bloc){
         return  RaisedButton(
                 onPressed : (){
                  bloc.add(SearchEvent('','productos'));
                  Navigator.pushNamed(context,'addproducto');
                 },
                   
                
                 textColor : Colors.white,
                 color     : Colors.teal,
                 child     : Text(
                             "Agregar Producto",
                              style: TextStyle(fontSize: 15),
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
  InputDecoration inputDecorador(icono,text,bloc){
     return InputDecoration(
            hintStyle      : TextStyle(color: Colors.black, fontSize: 15.0),
            //icon           : icono,
            contentPadding : EdgeInsets.all(10),
            errorStyle     : TextStyle(color: Colors.red),
            hintText       : text,
            suffixIcon     : text == 'Cliente'  
                                      ? IconButton(
                                        onPressed: (){
                                         
                                          Navigator.pushNamed(context,'addcliente');
                                           bloc.add(SearchEvent("",'clientes'));
                                        },
                                        icon: Icon(Icons.search),
                                      )
                                      : null,
            border         : OutlineInputBorder(borderRadius: BorderRadius.circular(50)) 
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

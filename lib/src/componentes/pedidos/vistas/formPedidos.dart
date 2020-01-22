import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pedidos/src/componentes/clientes/blocs/clientesBloc.dart/clientesBloc.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/bloc.dart';
import 'package:pedidos/src/componentes/productos/models/productosClass.dart';
import 'package:pedidos/src/plugins/formato.dart';

class FormPedidos extends StatefulWidget {
  
  FormPedidos({Key key}) : super(key: key);
  @override
  _FormPedidosState createState() => _FormPedidosState();
}

class _FormPedidosState extends State<FormPedidos> {

  final _pedidos             = GlobalKey<FormState>();
  final _scafold             = GlobalKey<ScaffoldState>();
  final _fococliente         = FocusNode();
  final _fococedula          = FocusNode();
  final _focodirecion        = FocusNode();
  final _clientecontroller   = TextEditingController();
  final _cedulacontroller    = TextEditingController();
  final _direccioncontroller = TextEditingController();
  final _cantidadcontroller  = TextEditingController();

  Color  primaryColor     = Colors.teal;
  
  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final formpedidoBloc = BlocProvider.of<FormPedidosBloc>(context);
    //ignore: close_sinks
    final pedidoBloc = BlocProvider.of<PedidosBloc>(context);
    //ignore: close_sinks
    final clienteBloc = BlocProvider.of<ClientesBloc>(context);
    return BlocBuilder<FormPedidosBloc, FormPedidoState>(
           builder: (context, state) {
              _clientecontroller.text = state.pedido.cliente.nombre;
              _cedulacontroller.text  = state.pedido.cliente.cedula;
              _direccioncontroller.text = state.pedido.cliente.direcion;
           return Scaffold(
                  key    : _scafold,
                  appBar : AppBar(
                           title     : state.update 
                                       ? Text("Actualizar Pedido")
                                       : Text("Agregar Pedido"),
                           iconTheme : IconThemeData(color: primaryColor),
                           actions: <Widget>[
                                                Padding(
                                                padding: EdgeInsets.all(20),
                                                child: Icon(MaterialCommunityIcons.cart_plus),
                                                )
                                      ],
                           ),
                  body   : GestureDetector(
                           onTap : () => FocusScope.of(context).unfocus(),
                           child : SingleChildScrollView(
                                   child: Form(
                                         key     : _pedidos,
                                         child   : Container(
                                                   padding : EdgeInsets.symmetric(
                                                             vertical   : 10, 
                                                             horizontal : 20
                                                             ),
                                                   child   : Column(
                                                             children: <Widget>[
                                                                          input(
                                                                          "Cliente", 
                                                                          _fococliente,
                                                                          Icon(FontAwesome5.user,color:primaryColor),
                                                                          state,
                                                                          _clientecontroller,
                                                                          formpedidoBloc
                                                                          ),
                                                                          SizedBox(height: 20),
                                                                          input(
                                                                          "Cedula",
                                                                          _fococedula,
                                                                          Icon(MaterialCommunityIcons.id_card,color:primaryColor),
                                                                          state,_cedulacontroller
                                                                          ),
                                                                          SizedBox(height: 20),
                                                                          input(
                                                                          "Direccion",
                                                                          _focodirecion,
                                                                          Icon(MaterialCommunityIcons.home_outline,color:primaryColor),
                                                                          state,_direccioncontroller
                                                                          ),
                                                                          SizedBox(height: 20),
                                                                          Text("Productos",style:TextStyle(fontSize: 18)),
                                                                          SizedBox(height: 10),
                                                                          addproductoBotton(context,formpedidoBloc),
                                                                          Container(
                                                                          padding   : EdgeInsets.all(10),
                                                                          alignment : Alignment.topRight,
                                                                          child     : Text("Cantidad",style: TextStyle(fontSize: 18)),
                                                                          ),
                                                                          listaProductos(state.pedido.productos, context,formpedidoBloc),
                                                                          ListTile(
                                                                          trailing : Text(
                                                                                     "${formatoMoney(state.total(state.pedido.productos))}",
                                                                                      style:TextStyle(
                                                                                            fontWeight : FontWeight.bold,
                                                                                            fontSize   : 25
                                                                                      )),
                                                                          title    : Text("Total"),

                                                                          ),
                                                                          SizedBox(height: 50)
                                                                       ],
                                                                ),
                                                      ),
                                              ),
                                      ),
                              ),
                   floatingActionButton: addpedidoButton(formpedidoBloc,pedidoBloc,clienteBloc,state)
      );
    }
    );
  }

  Widget input(String text,FocusNode foco,Icon icono,FormPedidoState state,controller,[bloc]) {
         
         TextInputAction textinput;
         text == 'Direccion' ? textinput = TextInputAction.newline 
                             : textinput = TextInputAction.next;
         return TextFormField(
                readOnly        : true,
                controller      : controller,
                validator       : (value) => value.isEmpty ? "Requerido": null,
                focusNode       : foco,
                textInputAction : textinput,
                decoration      : inputDecorador(icono, text,bloc,state),
                style           : TextStyle(color: primaryColor),
                cursorColor     : primaryColor,
                onChanged       : (value){
                                           switch (text) {
                                                   case "Cliente"   : state.pedido.cliente.nombre = value;
                                                                      break;
                                                   case "Cedula"    : state.pedido.cliente.cedula = value; 
                                                                      break;
                                                   case "Direccion" : state.pedido.cliente.direcion = value;
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
                                                                                    formpedidoBloc.add(DeleteProductoForm(producto[i].id,i));
                                                                                  
                                                                                   })
                                                                       )
                                                                       ],
                                                     actionPane : SlidableDrawerActionPane(),
                                                     child      : ListTile(
                                                                   subtitle : Text(
                                                                              formatoMoney(producto[i].precio),
                                                                              style: TextStyle(color: Colors.pink)),
                                                                   title    : Text(
                                                                              producto[i].productoNombre,
                                                                              style: TextStyle(fontSize: 20)
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
                 color     : primaryColor,
                 child     : Text(
                             "Agregar Producto",
                             style: TextStyle(fontSize: 15),
                             ),
                 shape     : RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
         );
  }  

  Widget addpedidoButton(FormPedidosBloc formpedidoBloc,pedidoBloc,clienteBloc,state){
         return FloatingActionButton( 
                child     : Icon(Icons.check),
                onPressed : () {
                                if (_pedidos.currentState.validate()){
                                      pedidoBloc.add(UpdatePedidos(state.pedido,state.update));
                                     //formpedidoBloc.add(ResetProducto());
                                     // formpedidoBloc.add(AddPedido());
                                     if(state.update){
                                        Navigator.pushReplacementNamed(context, 'home');
                                      } 
                                      else Navigator.pop(context);
                                      
                                }
                              },
         );
  } 
  
  InputDecoration inputDecorador(icono,text,bloc, FormPedidoState state){
     return InputDecoration(
            hintStyle      : TextStyle(color: primaryColor),
            icon           : icono,
            //contentPadding : EdgeInsets.all(10),
            errorStyle     : TextStyle(color: Colors.red),
            hintText       : text,
            suffixIcon     : text == 'Cliente'  
                                      ? IconButton(
                                        icon      :  !state.update ?
                                                     Icon(MaterialCommunityIcons.account_plus) :
                                                     Icon(MaterialCommunityIcons.account_edit) ,
                                        onPressed : (){
                                                        Navigator.pushNamed(context,'addcliente');
                                                        bloc.add(SearchEvent("",'clientes'));
                                                      }
                                        )
                                      : null,
            
        //prefixIcon : icono,
      );
  }

  updateCantidad(BuildContext context, List<Producto> producto,int i) {
  showDialog(
  context: context,
  builder: (context){
             _cantidadcontroller.text = producto[i].cantidad.toString();
             _cantidadcontroller.selection = TextSelection(
                                             baseOffset:0, 
                                             extentOffset:_cantidadcontroller.text.length
                                             );
            return AlertDialog(
                   title   : Text("Cantidad"),
                   content : Container(
                             child: TextFormField(
                              
                                    autofocus    : true,
                                    keyboardType : TextInputType.number,
                                    controller   : _cantidadcontroller,
                                    onChanged    : (value){producto[i].cantidad = int.parse(value);},
                                    textAlign    : TextAlign.center,
                                    decoration   : InputDecoration(border: InputBorder.none,contentPadding:EdgeInsets.all(20)),
                             ),
                            ),
                   actions: <Widget>[
                                     RaisedButton(
                                     color: primaryColor,
                                     textColor : Colors.white,
                                     onPressed : ()=>Navigator.pop(context),
                                     child     : Text("Aceptar"),
                                    )
                                  ]
            );                   
  }
  );
}

}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
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

  final _productos   = GlobalKey<FormState>();
  final _scafold     = GlobalKey<ScaffoldState>();
  final _fococodigo  = FocusNode();
  final _foconombre  = FocusNode();
  final _focoprecio  = FocusNode();

  PedidosRepositorio repo = PedidosRepositorio();
  Color  primaryColor     = Colors.pinkAccent;
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
                             appBar : AppBar(
                                      title: state.updateProducto 
                                             ?Text(
                                             "Actulizar Producto",  
                                              style: TextStyle(color: primaryColor)
                                              )
                                             :Text(
                                             "Agregar Producto",  
                                              style: TextStyle(color: primaryColor)
                                              ),
                                      iconTheme: IconThemeData(color: primaryColor),
                                      actions: <Widget>[
                                                Padding(
                                                padding: EdgeInsets.all(20),
                                                child: Icon(MaterialCommunityIcons.credit_card_plus),
                                                )
                                      ],
                                      ),
                             body   : GestureDetector(
                                      onTap : () => FocusScope.of(context).unfocus(),
                                      child : SingleChildScrollView(
                                              child: Form(
                                                     key     : _productos,
                                                     child   : Container(
                                                               padding : EdgeInsets.symmetric(
                                                                         vertical   : 30, 
                                                                         horizontal : 20
                                                               ),
                                                               child   : Column(
                                                                         children: <Widget>[
                                                                                    input("Codigo", _fococodigo, Icon(Ionicons.ios_barcode,color: primaryColor), state.producto,state.updateProducto),
                                                                                    SizedBox(height: 20),
                                                                                    input("Nombre", _foconombre, Icon(MaterialCommunityIcons.bottle_wine,color: primaryColor,), state.producto,false),
                                                                                    SizedBox(height: 20),
                                                                                    input("Precio", _focoprecio, Icon(FontAwesome5.money_bill_alt,color: primaryColor,), state.producto,false),
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

  Widget input(String text, FocusNode foco, Icon icono, Producto state,bool update) {

         TextInputAction textinput;
         text == 'Precio'    ? textinput = TextInputAction.done 
                             : textinput = TextInputAction.next;
         return TextFormField(
               readOnly        : update ,
               keyboardType    : text == 'Precio' ? TextInputType.number :null,
               validator       : (value) => value.isEmpty ? "Requerido": null,
               focusNode       : foco,
               textInputAction : textinput,
               decoration      : inputDecorador(icono, text),
               initialValue    : initialValue(text, state),
               style           : TextStyle(color: primaryColor),
               cursorColor     : primaryColor,
               onChanged       : (value){
                                          switch (text) {
                                            case "Codigo"   :  state.codigo = value;
                                                               break;
                                            case "Nombre"    : state.productoNombre = value; 
                                                               break;
                                            case "Precio"    : state.precio = int.parse(value);
                                                               break;
                                            default          : break;
                                          }
                                        },
              onEditingComplete : (){
                                     switch (text) {
                                       case 'Codigo' :  FocusScope.of(context).requestFocus(_foconombre);
                                                        break;
                                       case 'Nombre'  : FocusScope.of(context).requestFocus(_focoprecio); 
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
           case "Precio"    : return state.precio == 0 ? ''
                                     :state.precio.toString();
                              break;
           default          : break;
         }
         return null;
  }   
 
  Widget addpedidoButton(formpedidoBloc,productoBloc,fpedidobloc,FormProductoState state){
         return FloatingActionButton( 
                backgroundColor: primaryColor,
                child     : Icon(Icons.check),
                onPressed : () {
                               if (_productos.currentState.validate()){
                                    formpedidoBloc.add(AddproductoForm());
                                    productoBloc.add(UpdateProductos(state.producto,state.updateProducto));
                                    fpedidobloc.add(UpdateProductoForm(state.producto));
                                    Navigator.pop(context);
                               }
                              },
        );
  } 
  
  InputDecoration inputDecorador(icono,text){
     return InputDecoration(
            helperStyle    : TextStyle(color: Colors.red,fontSize: 18),
            hintStyle      : TextStyle(color: primaryColor),
            icon           : icono,
            //contentPadding : EdgeInsets.all(10),
            errorStyle     : TextStyle(color: Colors.red),
            hintText       : text,
            focusedBorder  : UnderlineInputBorder(
                             borderSide: BorderSide(color: primaryColor)
                           )
      );
  }
}

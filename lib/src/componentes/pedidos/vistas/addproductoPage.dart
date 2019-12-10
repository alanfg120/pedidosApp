import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/formpedidoBloc/formpedidoBloc.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/formpedidoBloc/formpedidoEvent.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/formpedidoBloc/formpedidoState.dart';
import 'package:pedidos/src/componentes/productos/data/repositorioProductos.dart';
import 'package:pedidos/src/componentes/productos/models/productosClass.dart';

class AddProductoPage extends StatefulWidget {
  AddProductoPage({Key key}) : super(key: key);

  @override
  _AddProductoPageState createState() => _AddProductoPageState();
}

class _AddProductoPageState extends State<AddProductoPage> {
  
    bool select = false;
   final controller = TextEditingController();  
   ProductosRepocitorio repo =  ProductosRepocitorio();
  @override
  void dispose() {
 
    super.dispose();
    Hive.close();
  }
  @override
  void initState(){ 
    super.initState();

  }
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
                                                    hintText  : "Buscar Producto",
                                                    hintStyle : TextStyle(fontSize: 20),
                                                    border    : InputBorder.none
                                                   ),
                                       onChanged  : (value){
                                                      formpedidoBloc.add(SearchProducto(value));
                                                    },
                                ),
                                actions: <Widget>[
                                         IconButton(
                                         icon      : Icon(Icons.cancel,color: Colors.grey,),
                                         onPressed : (){
                                                        controller.clear();
                                                        formpedidoBloc.add(SearchProducto(''));
                                                       },
                                         )
                                ],
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
                                                     title   : Text("Nuevo Producto"),
                                                     onTap   : ()=> Navigator.pushNamed(context, 'formproducto')
                                                    ),
                                            ),
                                            Divider(),
                                            Flexible(
                                              flex: 2,
                                              child: Padding(
                                                     padding: EdgeInsets.symmetric(vertical: 20),
                                                     child: Text("Todos los Productos",style: TextStyle(fontSize: 25),)
                                                     ),
                                            ),
                                            Flexible(
                                              flex: 8,
                                              child:  listaProductos(state.productos, bloc),
                                            )
                                            
                                    
                                         ],
                               );
           
                    }
                   
                   else if(state.query=='todos'){
                     return listaProductos(state.productos,bloc);
                   }
                   
                   else  {
                          final listaSugerida = state.productos.where( 
                                                 (p)=> p.productoNombre
                                                          .toLowerCase()
                                                          .startsWith(state.query.toLowerCase()))
                                                          .toList();
                          
                          return listaProductos(listaSugerida,bloc);
                        }
           
 
}

Widget listaProductos(List<Producto> productos,bloc) {
        return ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context,i){
                         return  ListTile(
                                  title: Text(productos[i].productoNombre),
                                  trailing:Checkbox(
                                           value: productos[i].select,
                                           onChanged: (value){
                                                              setState(() {
                                                                productos[i].select = value;
                                                                if(value)
                                                                bloc.add(AddProducto(producto:productos[i]));
                                                              }); 
                                                             },
                                          ),
                           );
              },          
        );
  }



}

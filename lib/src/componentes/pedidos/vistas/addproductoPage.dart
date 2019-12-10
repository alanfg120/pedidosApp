import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/formpedidoBloc/formpedidoBloc.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/formpedidoBloc/formpedidoEvent.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/formpedidoBloc/formpedidoState.dart';
import 'package:pedidos/src/componentes/productos/data/repositorioProductos.dart';

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
                                            ListTile(
                                            leading : Icon(Icons.add,color: Colors.green),
                                            title   : Text("Agregar Producto"),
                                            onTap   : (){
                                                  Navigator.pushNamed(context, 'formproducto');
                                            },
                                            ),
                                            ListTile(
                                            leading : Icon(Icons.list,color: Colors.green),
                                            title   : Text("Todos Productos"),
                                            onTap   : (){},
                                            )
                                         ],
                               );
           
                    }
                   else  return ListView.builder(
                                itemCount: state.productos.length,
                                itemBuilder: (context,i){
                                           
                                            return  ListTile(
                                               title: Text(state.productos[i].productoNombre),
                                                trailing:Switch (
                                             value: state.productos[i].select,
                                             onChanged: (value){
                                                setState(() {
                                                  state.productos[i].select = value;
                                                  if(value)bloc.add(AddProducto(producto:state.productos[i]));
                                                 });
                                                 },
                                           ),
                                             );
                                },
                   );
                   
                   
                   
                   /* return StreamBuilder(
                     stream :  repo.getProductos().asStream(),
                     builder: (BuildContext context, AsyncSnapshot<List<Producto>> snapshot) {
           
                       if(snapshot.hasData)
                       return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context,i){
                                    return ListTile(
                                           title: Text(snapshot.data[i].productoNombre),
                                           trailing:Switch (
                                             value: snapshot.data[i].select,
                                             onChanged: (value){
                                                setState(() {
                                                  snapshot.data[i].select = value;
                                                  if(value)bloc.add(AddProducto(producto:snapshot.data[i]));
                                                 });
                                                 },
                                           ),
                                    );
                     },
                     
                   );
                    else return Container();
                     }
                   ); */
                     
                   
                  /* return  BlocBuilder<ProductosBloc,ProductosState>(
                
                     bloc: ProductosBloc(repo:repo)..add(LoadProductos()),
                     builder: (context,stateProductos){
                        if(stateProductos is LoadedProductos){
                           return ListView.builder(
                                  itemCount: stateProductos.producto.length,
                                  itemBuilder: (context,i){
                                    return ListTile(
                                           title: Text(stateProductos.producto[i].productoNombre),
                                           trailing:Switch (
                                             
                                             value: stateProductos.producto[i].select,
                                             onChanged: (value){
                                                setState(() {
                                                  
                                                  stateProductos.producto[i].select = value;
                                                 // if(value)bloc.add(AddProducto(producto:stateProductos.producto[i]));
                                                });
           
                                               
                                                
                                             },
                                           ),
                                    );
                                  },
                           );
           
                        }
                        return Center(child: CircularProgressIndicator());
                     },
           
                   ); */
            
             }
           
 
}


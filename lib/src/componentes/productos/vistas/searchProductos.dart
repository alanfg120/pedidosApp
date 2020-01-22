import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pedidos/src/componentes/productos/blocs/bloc.dart';
import 'package:pedidos/src/componentes/productos/data/repositorioProductos.dart';
import 'package:pedidos/src/componentes/productos/models/productosClass.dart';
import 'package:pedidos/src/plugins/formato.dart';

class SearchProductoPage extends StatefulWidget {
  final List<Producto> productos;

  SearchProductoPage({Key key,this.productos}) : super(key: key);

  @override
  _SearchProductoPageState createState() => _SearchProductoPageState();
}

class _SearchProductoPageState extends State<SearchProductoPage> {

 
  @override
  void initState() {
     
   bloc.add(SearchProductoEvent(widget.productos,''));
   super.initState();
  }
  final bloc = ProductosBloc(repo: ProductosRepocitorio());
  Color primaryColor = Colors.pinkAccent;
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
                        bloc.add(SearchProductoEvent(widget.productos,value));
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
          body: BlocBuilder<ProductosBloc,ProductosState>(
                 bloc: bloc,
                 builder: (context, state) {
                   return resutlSearch(context, state);
                 },
        ));
  }

  Widget resutlSearch(BuildContext context, ProductosState state) {
    if(state is LoadedProductos)
       if(state.productos.isNotEmpty)
    return ListView.builder(
      itemCount: state.productos.length,
      itemBuilder: (BuildContext context, int i) {
                    return  Slidable(
                            secondaryActions: <Widget>[
                                                   IconSlideAction(
                                                   caption : 'Editar',
                                                   color   : primaryColor,
                                                   icon    : Icons.edit,
                                                   onTap:  (){
                                                          
                                                          BlocProvider.of<FormProductoBloc>(context).add(UpdateproductoForm(state.productos[i]));
                                                             Navigator.pushNamed(context, 'formproducto');  
                                                      
                                                          }
                                                   )
                                                   ],
                           actionPane : SlidableDrawerActionPane(),
                           child: ListTile(
                                  title    : Text(state.productos[i].productoNombre),
                                  subtitle : Text(state.productos[i].codigo),
                                  trailing : Text(formatoMoney(state.productos[i].precio),style: TextStyle(fontWeight:FontWeight.bold)),
                                  leading  : !state.productos[i].sincronizado
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

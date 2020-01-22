import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/bloc.dart';
import 'package:pedidos/src/componentes/pedidos/data/repositorioPedidos.dart';
import 'package:pedidos/src/componentes/pedidos/models/pedidosClass.dart';
import 'package:pedidos/src/componentes/pedidos/vistas/detallesPage.dart';
import 'package:pedidos/src/plugins/formato.dart';

class SearchPedidosPage extends StatefulWidget {
  final List<Pedido> pedidos;

  SearchPedidosPage({Key key,this.pedidos}) : super(key: key);

  @override
  _SearchPedidosPageState createState() => _SearchPedidosPageState();
}

class _SearchPedidosPageState extends State<SearchPedidosPage> {

 
  @override
  void initState() {
    
   bloc.add(SearchPedidoEvent(query: '',pedidos: widget.pedidos));
   super.initState();
  }
  final bloc = PedidosBloc(repo: PedidosRepositorio());
  Color primaryColor = Colors.teal;
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
                                    hintText: "Buscar Pedido",
                                    hintStyle: TextStyle(fontSize: 20),
                                    border: InputBorder.none
                                    ),
                       onChanged: (value) {
                         bloc.add(SearchPedidoEvent(query:value,pedidos: widget.pedidos));
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
          body: BlocBuilder<PedidosBloc, PedidosState>(
                 bloc: bloc,
                 builder: (context, state) {
                   return resutlSearch(context, state);
                 },
        ));
  }

  Widget resutlSearch(BuildContext context, PedidosState state) {
    if(state is LoadedPedidos)
       if(state.pedidos.isNotEmpty)
    return ListView.builder(
      itemCount: state.pedidos.length,
      itemBuilder: (BuildContext context, int i) {
                    return  Slidable(
                            secondaryActions: <Widget>[
                                                   IconSlideAction(
                                                   caption : 'Editar',
                                                   color   : primaryColor,
                                                   icon    : Icons.edit,
                                                   onTap:  (){
                                                            BlocProvider.of<FormPedidosBloc>(context).add(UpdatePedidoForm(state.pedidos[i]));
                                                            Navigator.pushNamed(context,'formpedidos');
                                                      
                                                          }
                                                   )
                                                   ],
                           actionPane : SlidableDrawerActionPane(),
                           child: ListTile(
                                  title    : Text(state.pedidos[i].cliente.nombre),
                                  subtitle : Text(formatoDate(state.pedidos[i].fecha.toString())),
                                  trailing : Text(
                                             //listpedidos[i].id,
                                             formatoMoney(state.pedidos[i].total),
                                             style: TextStyle(fontWeight: FontWeight.bold),
                                             ),
                                  leading  : !state.pedidos[i].sincronizado
                                             ? Icon(EvilIcons.check,color:primaryColor)
                                             : SizedBox(
                                               height : 20,
                                               width  : 20,
                                               child  : CircularProgressIndicator(
                                                        strokeWidth : 2,
                                                        valueColor  : AlwaysStoppedAnimation(primaryColor),
                                               ),
                                             ),
                                  onTap: (){
                                    Navigator.push(
                                    context, MaterialPageRoute(
                                             builder: (context)=>DetallesPedidoPage(pedido: state.pedidos[i])));
                                  },
                           ),
                                        );
     },
    );
    return Center(child:Text("Sin Resultados"));
  }
}

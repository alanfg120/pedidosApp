
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedidos/src/componentes/clientes/vistas/clientesPage.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/pedidosBloc/pedidosBloc.dart';
import 'package:pedidos/src/componentes/pedidos/vistas/pedidosPage.dart';
import 'package:pedidos/src/componentes/productos/vistas/productosPage.dart';


import 'package:pedidos/src/plugins/sharedpreferences.dart';
import 'package:pedidos/src/widgets/navigatorBar.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
 _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  Widget lastPage;
  
  bool syncauto;
  var colorItem    = Colors.grey; 

  final pref        = PreferenciasUsuario();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final floatBoton  = FloatingActionButtonLocation.centerDocked;
  
  int currentindex    = 0;

  List menuItemslist  = [
                         [Icons.shopping_cart, "Pedidos"      ,0 , Colors.teal],
                         [Icons.description  , "Productos"    ,1 , Colors.grey],
                         [Icons.person       , "Clientes"     ,2 , Colors.grey],
                         [Icons.settings     , "Configuracion",3 , Colors.grey],
                        ];
  List itemsSettings  = [
                         [Icon(Icons.lock)               ,Text("Cambiar contraseña")],
                         [Icon(Icons.refresh)            ,Text("Sincronizacion Automatica")],
                         [Icon(Icons.power_settings_new) ,Text("Cerrar Sesion")],
                        ];

  @override
  Widget build(BuildContext context) {
    
     final pedidosbloc = BlocProvider.of<PedidosBloc>(context);
    return Scaffold(
           key                 : scaffoldKey,
           body                : page(currentindex), 
           bottomNavigationBar : NavigatorBar(
                                 selectpage : (index){
                                                 page(index);
                                                 if(index==3)sheetBottom(context);
                                                  
                                              },
                                 items      : menuItemslist
                                 ),
           floatingActionButton: FloatingActionButton(
                                 onPressed       : (){
                                                        add(currentindex,pedidosbloc);
                                                     },
                                 backgroundColor : Colors.white,
                                 child           : Icon(Icons.add,color:Colors.teal),
                                 elevation       : 1.0
           
           ),
           floatingActionButtonLocation: floatBoton,
          );
  }
  
  Widget page(index) {
     
         setState(()=>currentindex = index);
         switch (currentindex) {
                 case 0 : lastPage = PedidosPage();
                          return PedidosPage();
                          break;
                 case 1 : lastPage = ProductosPage();
                          return ProductosPage();
                          break;
                 case 2 : lastPage = ClientesPage();
                          return ClientesPage();
                          break;
                 case 3 : return lastPage;
                          break;
                 default: return PedidosPage();
         }
  
  
  }
  
  sheetBottom(BuildContext context)  {
    showModalBottomSheet(
      context : context,
      builder : (BuildContext cn) =>
                  StatefulBuilder(
                   builder: (context,setState)=>
                              Container(
                                 height : MediaQuery.of(context).size.height * 0.3,
                                 child  : ListView.builder(
                                          itemCount   : itemsSettings.length,
                                          itemBuilder : (context,i)=> 
                                                           ListTile(
                                                           leading  : itemsSettings[i][0],
                                                           title    : itemsSettings[i][1],
                                                           trailing : i == 1 
                                                                        ? Switch(
                                                                           value    : pref.syncauto,
                                                                           onChanged: (value){
                                                                             setState(()  =>pref.syncauto=value
                                                                             );
                                                                           } 
                                                                         )
                                                                         : null,
                                                             onTap    : (){
                                                                            if(i==2)
                                                                            Navigator.pushReplacementNamed(context, 'login');
                                                                            if(i==0)print("pwd");
                                                                          },
                                                           )


                                          
                                 )
                                           
                                )
                      )
           );


}

  void add(int currentindex,PedidosBloc bloc) {

       switch (currentindex) {
                case 0  : Navigator.pushNamed(context, 'formpedidos');     
                          break;
                case 1  : Navigator.pushNamed(context, 'formproducto');     
                          break;
                case 2  : Navigator.pushNamed(context, 'formcliente');     
                          break;
                default :
       }

  }
 
  
}


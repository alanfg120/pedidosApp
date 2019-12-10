import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pedidos/src/componentes/home/homePage.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/formpedidoBloc/formpedidoBloc.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/formpedidoBloc/formpedidoEvent.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/pedidosBloc/pedidosBloc.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/pedidosBloc/pedidosEvent.dart';
import 'package:pedidos/src/componentes/pedidos/data/repositorioPedidos.dart';
import 'package:pedidos/src/componentes/pedidos/models/pedidosClass.dart';
import 'package:pedidos/src/componentes/productos/blocs/formproductoBloc/formproductoBloc.dart';
import 'package:pedidos/src/componentes/productos/blocs/productoBloc/productoBloc.dart';
import 'package:pedidos/src/componentes/productos/blocs/productoBloc/productoEvent.dart';
import 'package:pedidos/src/componentes/productos/data/repositorioProductos.dart';
import 'package:pedidos/src/componentes/productos/models/productosClass.dart';
import 'package:pedidos/src/plugins/blocDelegate.dart';
import 'package:pedidos/src/plugins/sharedpreferences.dart';


import 'package:pedidos/src/rutas.dart';



void main() async {
 WidgetsFlutterBinding.ensureInitialized();
// ---- Shared Preferences -----

 final prefs = new PreferenciasUsuario();
 await prefs.initPrefs();
 
// ---- Hive Db ----------------
 final path = await getApplicationDocumentsDirectory();
 Hive.init(path.path);

 Hive.registerAdapter(PedidoAdapter(), 0);
 Hive.registerAdapter(ProductoAdapter(),1);
 BlocSupervisor.delegate = SimpleBlocDelegate();

/* final box =await Hive.openBox('productos');
 box.clear(); */
 runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final PedidosRepositorio repoPedidos=PedidosRepositorio();
  final ProductosRepocitorio repoProductos=ProductosRepocitorio();
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider (
          providers: [
                      BlocProvider<PedidosBloc>(
                      create: (context) => PedidosBloc(repo: repoPedidos)..add(LoadPedidos()),
                      ),
                      BlocProvider<FormPedidosBloc>(
                      create: (context) => FormPedidosBloc(repo: repoPedidos)..add(GetProducto()),
                      ),
                      BlocProvider<ProductosBloc>(
                      create: (context) => ProductosBloc(repo: repoProductos)..add(LoadProductos()),
                      ),
                      BlocProvider<FormProductoBloc>(
                      create: (context) => FormProductoBloc(repo: repoProductos),
                      ),
                     ],
          child: MaterialApp(
        
          debugShowCheckedModeBanner: false,
          title: 'Pedidos',
          theme: ThemeData(
                 primarySwatch : Colors.teal,
                 appBarTheme   : AppBarTheme(
                                 elevation  : 0.0, 
                                 color      : Colors.white,
                                 brightness : Brightness.light,
                                 iconTheme  : IconThemeData(color:Colors.teal), 
                                 textTheme  : TextTheme(title : TextStyle(
                                                                color: Colors.teal,
                                                                fontSize: 30.0,
                                                                fontFamily: 'Alata'
                                                                ))
                                 ),
               
          ),
          home   : HomePage(),
          routes : route()
          ),
    );
  }
}

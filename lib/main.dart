import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedidos/src/componentes/clientes/blocs/clientesBloc.dart/clientesBloc.dart';
import 'package:pedidos/src/componentes/clientes/blocs/clientesBloc.dart/clientesEvent.dart';
import 'package:pedidos/src/componentes/clientes/blocs/formclientBloc.dart/formclientesBloc.dart';
import 'package:pedidos/src/componentes/clientes/data/repositorioCliente.dart';
import 'package:pedidos/src/componentes/home/homePage.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/formpedidoBloc/formpedidoBloc.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/formpedidoBloc/formpedidoEvent.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/pedidosBloc/pedidosBloc.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/pedidosBloc/pedidosEvent.dart';
import 'package:pedidos/src/componentes/pedidos/data/repositorioPedidos.dart';
import 'package:pedidos/src/componentes/productos/blocs/formproductoBloc/formproductoBloc.dart';
import 'package:pedidos/src/componentes/productos/blocs/productoBloc/productoBloc.dart';
import 'package:pedidos/src/componentes/productos/blocs/productoBloc/productoEvent.dart';
import 'package:pedidos/src/componentes/productos/data/repositorioProductos.dart';
import 'package:pedidos/src/plugins/blocDelegate.dart';
import 'package:pedidos/src/plugins/sharedpreferences.dart';


import 'package:pedidos/src/rutas.dart';



void main() async {
 WidgetsFlutterBinding.ensureInitialized();
// ---- Shared Preferences -----

 final prefs = new PreferenciasUsuario();
 await prefs.initPrefs();
 
// ---- Hive Db ----------------
 /* final path = await getApplicationDocumentsDirectory();
 Hive.init(path.path);
 Hive.registerAdapter(PedidoAdapter(), 0);
 Hive.registerAdapter(ProductoAdapter(),1);
 Hive.registerAdapter(ClienteAdapter(),2); */
 BlocSupervisor.delegate = SimpleBlocDelegate();

 /* var box =await Hive.openBox('pedidos');
 box.clear(); */
 runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final PedidosRepositorio repoPedidos=PedidosRepositorio();
  final ProductosRepocitorio repoProductos= ProductosRepocitorio();
  final ClientesRepositorio repoClientes= ClientesRepositorio();
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider (
          providers: [
                      BlocProvider<PedidosBloc>(
                      create: (context) => PedidosBloc(repo: repoPedidos)..add(LoadPedidos()),
                      ),
                      BlocProvider<FormPedidosBloc>(
                      create: (context) => FormPedidosBloc(repo: repoPedidos)..add(GetProducto())..add(GetCliente()),
                      ),
                      BlocProvider<ProductosBloc>(
                      create: (context) => ProductosBloc(repo: repoProductos)..add(LoadProductos()),
                      ),
                      BlocProvider<ClientesBloc>(
                      create: (context) => ClientesBloc(repo: repoClientes)..add(LoadClientes()),
                      ),
                      BlocProvider<FormProductoBloc>(
                      create: (context) => FormProductoBloc(repo: repoProductos),
                      ),
                      BlocProvider<FormClienteBloc>(
                      create: (context) => FormClienteBloc(repo:repoClientes),
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
                                                                fontSize: 25.0,
                                                                //fontFamily: 'Alata'
                                                                ))
                                 ),
               
          ),
          home   : HomePage(),
          routes : route()
          ),
    );
  }
}

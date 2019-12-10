import 'package:flutter/material.dart';
import 'package:pedidos/src/componentes/login/loginPage.dart';
import 'package:pedidos/src/componentes/pedidos/vistas/formPedidos.dart';
import 'package:pedidos/src/componentes/productos/vistas/formProductos.dart';
import 'componentes/home/homePage.dart';
import 'componentes/pedidos/vistas/addproductoPage.dart';
import 'componentes/pedidos/vistas/pedidosPage.dart';


Map<String, WidgetBuilder> route() {
  return <String, WidgetBuilder>{
    'login'           : (context) => Login(),
    'home'            : (context) => HomePage(),
    'pedidos'         : (context) => PedidosPage(),
    'formpedidos'     : (context) => FormPedidos(),
    'formproducto'    : (context) => FormProductos(),
    'addproducto'     : (context) => AddProductoPage(),
    
    
  };
}

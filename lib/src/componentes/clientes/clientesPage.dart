import 'package:flutter/material.dart';

class ClientesPage extends StatefulWidget {
  ClientesPage({Key key}) : super(key: key);

  @override
  _ClientesPageState createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
                centerTitle : false,
                title       : Text(
                               "Clientes",
                                style: TextStyle(
                                       color      : Colors.teal,
                                       fontSize   : 35.0,
                                       fontWeight : FontWeight.w300,
                                       fontFamily : "Alata"
                                       )
                             ),
                actions : <Widget>[
                            IconButton(
                              icon      : Icon(
                                           Icons.search,
                                           color : Colors.teal,
                                           size  : 30.0,
                                          ),
                              onPressed : (){},
                            )
                ],
       ),
    );
  }
}
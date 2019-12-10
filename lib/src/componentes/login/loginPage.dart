
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String usuario;
  String pwd;

  double c             = 0;
  BorderRadius border  = BorderRadius.circular(50);
  final scaffoldKey    = GlobalKey<ScaffoldState>();
  final _login         = GlobalKey<FormState>();
  final _focousuario   = FocusNode();
  final _focopassword  = FocusNode();

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
           
           key  : scaffoldKey,
           body : Stack(
                  children: <Widget>[
                    Image(
                    image: AssetImage("assets/fondo.jpg"),
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height,
                    ),
                    GestureDetector(
                    onTap: ()=>FocusScope.of(context).unfocus(),
                    child: SingleChildScrollView(
                           padding : EdgeInsets.all(30),
                           child   : Form(
                                     key   : _login,
                                     child : Column(
                                             crossAxisAlignment : CrossAxisAlignment.stretch,
                                             children           : <Widget>[
                                                                   //image(),
                                                                   Container(
                                                                    height: MediaQuery.of(context).size.height * 0.3,
                                                                    alignment: Alignment.center,
                                                                    child: Text(
                                                                            "PedidosApp",
                                                                             style: TextStyle(
                                                                                     fontFamily    : "Alata",
                                                                                     color         : Colors.white,
                                                                                     fontSize      : 45.0,
                                                                                     fontWeight    : FontWeight.w900,
                                                                                     letterSpacing : 3.0,
                                                                                     shadows: [
                                                                                                Shadow(
                                                                                                    blurRadius: 2.0,
                                                                                                    color: Colors.teal,
                                                                                                    offset: Offset(5.0, 5.0),
                                                                                                    )
                                                                                               ]
                                                                                   
                                                                            )
                                                                      ),
                                                                   ),
                                                                   input("Usuario",Icon(Icons.person,color: Colors.white),false,_focousuario),
                                                                   SizedBox(height: 60),
                                                                   input("Contraseña", Icon(Icons.lock,color: Colors.white),true,_focopassword),
                                                                   SizedBox(height: 60),
                                                                   boton(context)
                                                                 ],
                                             ),
                                     
                                           ),
                               ),
                   )
                  ],
           )
           
           
           
                
       );
        
  }

  Widget input(String text, Icon icono, bool password,FocusNode foco) {

         TextInputAction textinput;
         if(password)textinput=TextInputAction.send;
         else        textinput=TextInputAction.next;

         return TextFormField(
                 style             : TextStyle(color: Colors.white,fontSize: 23.0),
                 cursorColor       : Colors.white,
                 onChanged         : (value){
                                       if(password)pwd=value;
                                       else usuario=value;
                                     },
                 validator         : (value) {
                                      if(value.isEmpty)return "Es requerido";
                                      return null;
                                     },
                 onEditingComplete :(){
                                     if(password) onsubmit(context);
                                     else FocusScope.of(context).requestFocus(_focopassword);
                                     },                  
                 focusNode         : foco,
                 textInputAction   : textinput,
                 obscureText       : password,
                 decoration        : InputDecoration(
                                     
                                     errorStyle : TextStyle(color: Colors.pink),
                                     hintText   : text,
                                     focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                                color: Colors.white,
                                                                style: BorderStyle.solid,
                                                                width: 2.0
                                                               )
                                                ),
                                    enabledBorder: OutlineInputBorder(
                                                   borderSide: BorderSide(
                                                               color: Colors.white,
                                                               style: BorderStyle.solid,
                                                               width: 2.0
                                                              )
                                                   ),
                                     prefixIcon : icono,
                                     hintStyle  : TextStyle(color: Colors.white,fontSize: 20.0),
                                     
                                     ),
                                      );
   
  }

  Widget boton(context) {
         return RaisedButton(
                onPressed : ()=>onsubmit(context),
                padding   : EdgeInsets.all(15.0),
                textColor : Colors.white,
                color     : Colors.teal,  
                child     : Text(
                            "Ingresar",
                             style: TextStyle(fontSize: 20.0),
                            ),         
                                        
              );
        
  }

Widget image() {
       return Container(
              height : 300,
              width  : 100,
              child: Image.asset("assets/login.png"),
       );
}

  void onsubmit(context) async {
     /*   if (_login.currentState.validate()) {
                  final logeado= await post.login(usuario,pwd);
              
                  if(logeado) Navigator.pushReplacementNamed(context, 'home');
                  else        scaffoldKey.currentState.showSnackBar(
                                                   SnackBar(
                                                   behavior : SnackBarBehavior.floating,
                                                   content  : Text('Datos Incorrectos'),
                                                   duration : Duration(seconds: 3),
                                                   action   : SnackBarAction(
                                                              textColor: Colors.pink,
                                                              onPressed: (){},
                                                              label: "Aceptar",
                                                             ),
                                                   )
                               );    
       } */
}   
}



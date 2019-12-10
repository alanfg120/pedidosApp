import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  
  }

  
  // GET y SET del token
  get token               => _prefs.getString('token') ?? '';
  set token(String value) => _prefs.setString('token', value);
  

  // GET y SET del sincronizacion automatica
  get syncauto       =>  _prefs.getBool('syncauto') ?? false;
  set syncauto(value)=>  _prefs.setBool('syncauto', value);

  
  
   eraseall(){
    this._prefs.clear();
  }


}



import 'package:bloc/bloc.dart';
import 'package:pedidos/src/componentes/productos/blocs/formproductoBloc/formproductoEvent.dart';
import 'package:pedidos/src/componentes/productos/blocs/formproductoBloc/formproductoState.dart';
import 'package:pedidos/src/componentes/productos/data/repositorioProductos.dart';

class FormProductoBloc extends Bloc<FormProductoEvent,FormProductoState>{
 
   ProductosRepocitorio repo;
   FormProductoBloc({this.repo});
  @override
  FormProductoState get initialState => FormProductoState.inicial();
  
 
  
  
  @override
  Stream<FormProductoState> mapEventToState(FormProductoEvent event) async* {
   if(event is AddproductoForm)
      yield* _mapAddproductoEvent(event);
  }
   
   Stream<FormProductoState> _mapAddproductoEvent(AddproductoForm event) async* {
    
    //repo.setProducto(event.producto);
    yield FormProductoState.inicial();  
  
   }
  



}
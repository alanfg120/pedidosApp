import 'package:bloc/bloc.dart';
import 'package:pedidos/src/componentes/clientes/blocs/formclientBloc.dart/formclienteEvent.dart';
import 'package:pedidos/src/componentes/clientes/blocs/formclientBloc.dart/formclienteState.dart';
import 'package:pedidos/src/componentes/clientes/data/repositorioCliente.dart';

class FormClienteBloc extends Bloc<FormClienteEvent,FormClienteState>{
 
   ClientesRepositorio repo;
   FormClienteBloc({this.repo});
  @override
  FormClienteState get initialState => FormClienteState.inicial();
  
 
  
  
  @override
  Stream<FormClienteState> mapEventToState(FormClienteEvent event) async* {
   if(event is AddclienteForm)
      yield* _mapAddproductoEvent(event);
  }
   
   Stream<FormClienteState> _mapAddproductoEvent(AddclienteForm event) async* {
    
    //repo.setProducto(event.producto);
    yield FormClienteState.inicial();  
  
   }
}
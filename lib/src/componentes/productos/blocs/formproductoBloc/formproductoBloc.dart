import 'package:bloc/bloc.dart';
import 'package:pedidos/src/componentes/productos/blocs/formproductoBloc/formproductoEvent.dart';
import 'package:pedidos/src/componentes/productos/blocs/formproductoBloc/formproductoState.dart';
import 'package:pedidos/src/componentes/productos/data/repositorioProductos.dart';

class FormProductoBloc extends Bloc<FormProductoEvent, FormProductoState> {
  ProductosRepocitorio repo;
  FormProductoBloc({this.repo});
  @override
  FormProductoState get initialState => FormProductoState.inicial();

  @override
  Stream<FormProductoState> mapEventToState(FormProductoEvent event) async* {
    if (event is AddproductoForm) yield* _mapAddproductoEvent();
    if (event is UpdateproductoForm) yield* _mapUpdateproductoFormEvent(event);
  }

  Stream<FormProductoState> _mapAddproductoEvent() async* {
    yield FormProductoState.inicial();
  }

  Stream<FormProductoState> _mapUpdateproductoFormEvent(
      UpdateproductoForm event) async* {
      yield  state.copyWith(
        producto: event.producto,
        updateProducto: true
      );

      }
}

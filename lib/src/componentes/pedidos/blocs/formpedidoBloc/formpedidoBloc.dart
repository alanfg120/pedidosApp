import 'package:bloc/bloc.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/formpedidoBloc/formpedidoEvent.dart';
import 'package:pedidos/src/componentes/pedidos/blocs/formpedidoBloc/formpedidoState.dart';
import 'package:pedidos/src/componentes/pedidos/data/repositorioPedidos.dart';
import 'package:pedidos/src/componentes/productos/data/repositorioProductos.dart';
import 'package:pedidos/src/componentes/productos/models/productosClass.dart';



class FormPedidosBloc extends Bloc<FormPedidoEvent,FormPedidoState>{

  PedidosRepositorio repo;
  ProductosRepocitorio repoProducto= ProductosRepocitorio();
  FormPedidosBloc({this.repo});
  
  @override
  FormPedidoState get initialState => FormPedidoState.inicial();
  
  @override
  Stream<FormPedidoState> mapEventToState(FormPedidoEvent event) async* {
  if (event is AddPedido)
       yield* _mapAddpedidoState(event);
  if (event is AddProducto)
       yield* _mapAddproductoState(event);
  if (event is SearchProducto)
       yield* _mapSearchProductoState(event);
  if (event is GetProducto)
       yield* _mapGetProductotate();
  if (event is UpdateProductoForm)
       yield* _mapUpdateProductoFormstate(event);
  if (event is ResetProducto)
       yield* _mapResetProductostate();
  }

  Stream<FormPedidoState> _mapAddpedidoState(AddPedido event) async* {
     repo.setPedido(event.pedido);
     yield state.copyWith(
                 pedido: initialState.pedido,
                 query: '',
                 productos: state.productos
                 );
  }

  Stream<FormPedidoState> _mapAddproductoState(AddProducto event) async* {
    state.pedido.productos.add(event.producto);
    yield state.copyWith(pedido:state.pedido,query:state.query,productos: state.productos);

  }

  Stream<FormPedidoState> _mapSearchProductoState(SearchProducto event) async* {
   yield state.copyWith(pedido:state.pedido,query: event.query,productos: state.productos);
   
  }

  Stream<FormPedidoState> _mapGetProductotate() async* {
   final List<Producto> productos = await repoProducto.getProductos();
   yield state.copyWith(pedido:state.pedido,query:'',productos: productos); 
  
  }

  Stream<FormPedidoState> _mapUpdateProductoFormstate(UpdateProductoForm event) async* {
     state.productos.add(event.producto);
     yield state.copyWith(pedido:state.pedido,query:'',productos: state.productos); 

  }

 Stream<FormPedidoState> _mapResetProductostate() async* {
       state.productos.forEach((p){
         p.cantidad = 0;
         p.select   = false;
       });
 
 yield state.copyWith(pedido:state.pedido,query:'',productos: state.productos); 
 }
  
  

  

}


import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pedidos/src/componentes/productos/blocs/productoBloc/productoEvent.dart';
import 'package:pedidos/src/componentes/productos/blocs/productoBloc/productoState.dart';
import 'package:pedidos/src/componentes/productos/data/repositorioProductos.dart';
import 'package:pedidos/src/componentes/productos/models/productosClass.dart';

class ProductosBloc extends Bloc<ProductosEvent,ProductosState>{

 ProductosRepocitorio repo;
 ProductosBloc({@required this.repo});

  @override
  ProductosState get initialState => LoadingProductos();

  @override
  Stream<ProductosState> mapEventToState(ProductosEvent event) async* {
     if(event is LoadProductos) 
      yield* _mapLoadedProductosEvent();
     if(event is UpdateProductos) 
      yield* _mapUpdateProductosEvent(event,state);
     if(event is UploadProductos) 
      yield* _mapUploadProductosEvent();

  }
      
     Stream<ProductosState> _mapLoadedProductosEvent() async* {
     final List<Producto> productos = await repo.getProductos();
     yield LoadedProductos(productos); 

     }

  Stream<ProductosState> _mapUpdateProductosEvent(UpdateProductos event, LoadedProductos state) async*{
    bool exist = false;
    state.productos.forEach((p){
    if(p.codigo == event.producto.codigo){
       exist = true;
    }
   });
    if(!exist){
       state.productos.add(event.producto);
       repo.setProducto(event.producto).listen((data){
          print(data.documentID);
           
       });
    }
    
    yield LoadedProductos(state.productos); 

  }

  Stream<ProductosState> _mapUploadProductosEvent() async* {

    yield UploadedProductos();

  }

  

  
}
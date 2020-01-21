import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pedidos/src/componentes/productos/blocs/productoBloc/productoEvent.dart';
import 'package:pedidos/src/componentes/productos/blocs/productoBloc/productoState.dart';
import 'package:pedidos/src/componentes/productos/data/repositorioProductos.dart';
import 'package:pedidos/src/componentes/productos/models/productosClass.dart';
import 'package:pedidos/src/plugins/uid.dart';

class ProductosBloc extends Bloc<ProductosEvent, ProductosState> {
  ProductosRepocitorio repo;
  ProductosBloc({@required this.repo});

  @override
  ProductosState get initialState => LoadingProductos();

  @override
  Stream<ProductosState> mapEventToState(ProductosEvent event) async* {
    if (event is LoadProductos) yield* _mapLoadedProductosEvent();
    if (event is UpdateProductos) yield* _mapUpdateProductosEvent(event, state);
    if (event is UploadProductos) yield* _mapUploadProductosEvent(event, state);
    if (event is SearchProductoEvent) yield* _searchProducto(event);
  }

  Stream<ProductosState> _mapLoadedProductosEvent() async* {
    final List<Producto> productos = await repo.getProductos();
    yield LoadedProductos(productos);
  }

  Stream<ProductosState> _mapUpdateProductosEvent(
      UpdateProductos event, LoadedProductos state) async* {
    if (event.update) {
      event.producto.sincronizado=true;
     repo.updateProducto(event.producto).listen((data){
      add(UploadProductos(event.producto.codigo));

     });
    } else {
      bool exist = false;
      state.productos.forEach(
          (p) => p.codigo == event.producto.codigo ? exist = true : null);
      if (!exist) {
        event.producto.id = createUid();
        state.productos.add(event.producto);
        repo
            .setProducto(event.producto)
            .listen((data) => add(UploadProductos(event.producto.codigo)));
      }
    }

    yield LoadedProductos(state.productos);
  }

  Stream<ProductosState> _mapUploadProductosEvent(
      UploadProductos event, LoadedProductos state) async* {
    state.productos.forEach((p) {
      if (p.codigo == event.codidoProducto) p.sincronizado = false;
    });
    yield UploadFireBaseProductos();
    yield LoadedProductos(state.productos);
  }

  Stream<ProductosState> _searchProducto(SearchProductoEvent event) async* {

     if (event.query.isEmpty) {
      yield LoadedProductos([]);
    } else {
      final listaSugerida = event.productos
          .where((p) => p.productoNombre
              .toLowerCase()
              .startsWith(event.query.toLowerCase()))
          .toList();
      yield LoadedProductos(listaSugerida);
    }

  }
}

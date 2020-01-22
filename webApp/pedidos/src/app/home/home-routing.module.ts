import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { HomeComponent } from './vistas/home/home.component';


const routes: Routes = [
  {
    path:'',
    component:HomeComponent,
    children:[
      {
        path:"pedidos",
        loadChildren:"./../pedidos/pedidos.module#PedidosModule"
      },
      {
        path:"productos",
        loadChildren:"./../productos/productos.module#ProductosModule"
      },
      {
        path:"clientes",
        loadChildren:"./../clientes/clientes.module#ClientesModule"
      }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class HomeRoutingModule { }

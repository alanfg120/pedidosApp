import { NgModule } from "@angular/core";
import { Routes, RouterModule, PreloadAllModules } from "@angular/router";

const routes: Routes = [
  {
    path:'login',
    loadChildren:"./login/login.module#LoginModule"
  },
  {
    path:'home',
    loadChildren:"./pedidos/pedidos.module#PedidosModule"
  },
  {
    path:'**',
    loadChildren:"./pedidos/pedidos.module#PedidosModule"
  }
];

@NgModule({
  imports: [
    RouterModule.forRoot(routes, {
      useHash: true,
      preloadingStrategy: PreloadAllModules
    })
  ],
  exports: [RouterModule]
})
export class AppRoutingModule {}

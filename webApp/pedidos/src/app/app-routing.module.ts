import { NgModule } from "@angular/core";
import { Routes, RouterModule, PreloadAllModules } from "@angular/router";

const routes: Routes = [
  {
    path:'',
    loadChildren:"./login/login.module#LoginModule"
  },
  {
    path:'home',
    loadChildren:"./home/home.module#HomeModule"
  },
  {
    path:'**',
    loadChildren:"./login/login.module#LoginModule"
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


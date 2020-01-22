import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {
   
  titulo  : string="Pedidos";
  color:string ="primary" 
  constructor() { }
  
  ngOnInit() {
  }


  router(event) {
    this.titulo = event.titulo;
    if(event.titulo=="Pedidos")this.color="primary"
    if(event.titulo=="Productos")this.color="accent"
    if(event.titulo=="Clientes")this.color="warn"
    
}
}

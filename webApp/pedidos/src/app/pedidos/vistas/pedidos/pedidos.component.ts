import { Component, OnInit, ChangeDetectionStrategy } from "@angular/core";
import { PedidosService } from "../../servicios/pedidos.service";
import { Observable, from } from "rxjs";
import { Pedido } from '../../models/pedidos.model';

@Component({
  selector: "app-pedidos",
  templateUrl: "./pedidos.component.html",
  styleUrls: ["./pedidos.component.css"]
})
export class PedidosComponent implements OnInit {
  pedidos: Observable<Pedido[]>;
  productos = [];
  titulo: string = "Pedidos";
  idselect:string;
  total:string;
  constructor(public pedidosService: PedidosService) {}

  ngOnInit() {
    this.pedidos = this.pedidosService.getPedidos();
    this.pedidos.subscribe((data:Pedido[]) => {
   console.log(data);
   
     data.forEach((pedido)=>{
      if(pedido.id==this.idselect)this.detalles(pedido,pedido.id)
     })
    
    });
  }
  detalles(pedido,id) {
    this.productos = pedido.productos;
    this.total= pedido.total
    this.idselect=id;
  }
}

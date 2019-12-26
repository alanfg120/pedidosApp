import { Component, OnInit } from '@angular/core';
import { PedidosService } from '../../servicios/pedidos.service';
import { Observable } from 'rxjs';


@Component({
  selector: 'app-pedidos',
  templateUrl: './pedidos.component.html',
  styleUrls: ['./pedidos.component.css']
})
export class PedidosComponent implements OnInit {
   pedidos:Observable<any>
  constructor(
    public pedidosService:PedidosService
  ) { }

  ngOnInit() {
    this.pedidos=this.pedidosService.getPedidos()
  }





}

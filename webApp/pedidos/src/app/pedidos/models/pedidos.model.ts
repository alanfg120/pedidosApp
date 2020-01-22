import { Cliente } from '../../clientes/models/cliente.class';
import { Producto } from '../../productos/models/producto.class';

interface Timestamp {
    seconds: number,
    nanoseconds: number,
}

export class Pedido {

  public cliente   :Cliente;
  public productos :Producto[];
  public total:number;
  public fecha:Timestamp;
  public id:string;
  public actulizado:boolean;
  



    
}
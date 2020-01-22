import { Injectable } from "@angular/core";
import {
  AngularFirestore,
  AngularFirestoreDocument
} from "@angular/fire/firestore";
import { map } from "rxjs/operators";
@Injectable({
  providedIn: "root"
})
export class PedidosService {
  constructor(private firestore: AngularFirestore) {}

  getPedidos() {
    return this.firestore
      .collection("panchita/001/pedidos", ref => ref.orderBy("fecha"))
      .valueChanges({ idField: "id" })
      .pipe(
        map((data: any) => data.reverse())

      );
  }
}

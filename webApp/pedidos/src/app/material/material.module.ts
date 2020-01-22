import { NgModule } from "@angular/core";
import { CommonModule } from "@angular/common";
import { MatToolbarModule } from "@angular/material/toolbar";
import { MatIconModule } from "@angular/material/icon";
import { MatButtonModule } from "@angular/material/button";
import { MatSidenavModule } from "@angular/material/sidenav";
import { MatExpansionModule } from "@angular/material/expansion";
import { MatListModule } from "@angular/material/list";
import { MatDividerModule } from "@angular/material/divider";
import { MatFormFieldModule } from "@angular/material/form-field";
import { MatInputModule } from "@angular/material/input";
import { MatCardModule } from "@angular/material/card";
import { MatTableModule } from "@angular/material/table";
import { MatDatepickerModule } from "@angular/material/datepicker";
import { MatNativeDateModule } from "@angular/material/core";
import { MatSelectModule } from "@angular/material/select";
import { MatRadioModule } from "@angular/material/radio";
import { MatTabsModule } from "@angular/material/tabs";
import { MatProgressSpinnerModule } from "@angular/material/progress-spinner";
import { MatProgressBarModule } from "@angular/material/progress-bar";
import {MatMenuModule} from '@angular/material/menu';
import {MatBadgeModule} from '@angular/material/badge';

import {
  MomentDateModule,
  MomentDateAdapter
} from "@angular/material-moment-adapter";
import {
  DateAdapter,
  MAT_DATE_FORMATS,
  MAT_DATE_LOCALE,
  MatPaginatorModule,
  MatSortModule
} from "@angular/material";

import { MatDialogModule } from "@angular/material/dialog";

import { MatCheckboxModule } from "@angular/material/checkbox";

export const MY_FORMATS = {
  parse: {
    dateInput: "D [de] MMMM [de] YYYY"
  },
  display: {
    dateInput: "D [de] MMMM [de] YYYY",
    monthYearLabel: "MM YYYY",
    dateA11yLabel: "D [de] MMMM [de] YYYY",
    monthYearA11yLabel: "MM YYYY"
  }
};

@NgModule({
  declarations: [],
  imports: [CommonModule],
  exports: [
    MatToolbarModule,
    MatIconModule,
    MatButtonModule,
    MatSidenavModule,
    MatExpansionModule,
    MatListModule,
    MatDividerModule,
    MatFormFieldModule,
    MatInputModule,
    MatCardModule,
    MatTableModule,
    MatDatepickerModule,
    MatNativeDateModule,
    MatSelectModule,
    MatRadioModule,
    MomentDateModule,
    MatTabsModule,
    MatPaginatorModule,
    MatMenuModule,
    MatDialogModule,
    MatSortModule,
    MatProgressSpinnerModule,
    MatProgressBarModule,
    MatCheckboxModule,
    MatBadgeModule
  ],
  providers:[ { provide: MAT_DATE_LOCALE, useValue: "es-ES" },
  {
    provide: DateAdapter,
    useClass: MomentDateAdapter,
    deps: [MAT_DATE_LOCALE]
  },
  { provide: MAT_DATE_FORMATS, useValue: MY_FORMATS }]
})
export class MaterialModule {}

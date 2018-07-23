import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { ReactiveFormsModule, FormsModule }  from '@angular/forms';
import { MaterializeModule } from '../../../node_modules/angular2-materialize';

import { CoreModule } from '../core/core.module';
import { VMessageModule } from '../shared/components/vmessage/vmessage.module';
import { GrupoListaComponent } from './lista/grupo-lista.component';
import { GrupoDadosComponent } from './dados/grupo-dados.component';
import { GrupoFormComponent } from './form/grupo-form.component';

@NgModule({
  declarations: [
    GrupoListaComponent,
    GrupoDadosComponent,
    GrupoFormComponent
  ],
  imports: [
    CommonModule,
    CoreModule,
    RouterModule,
    ReactiveFormsModule,
    FormsModule,
    VMessageModule,
    MaterializeModule
  ]
})
export class GruposModule { }

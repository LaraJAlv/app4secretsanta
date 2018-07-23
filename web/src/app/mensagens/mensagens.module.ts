import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { ReactiveFormsModule, FormsModule }  from '@angular/forms';

import { CoreModule } from '../core/core.module';
import { VMessageModule } from '../shared/components/vmessage/vmessage.module';
import { MensagemListaComponent } from './lista/mensagem-lista.component';
import { MensagemDadosComponent } from './dados/mensagem-dados.component';

@NgModule({
  declarations: [ 
    MensagemListaComponent,
    MensagemDadosComponent
  ],
  imports: [
    CommonModule,
    CoreModule,
    RouterModule,
    ReactiveFormsModule,
    FormsModule,
    VMessageModule,
  ],
})
export class MensagensModule { }

import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { HTTP_INTERCEPTORS } from '@angular/common/http';
import { MaterializeModule } from 'angular2-materialize';

import { VMessageModule } from './shared/components/vmessage/vmessage.module';
import { AppRoutingModule } from './app.routing.module';
import { AppComponent } from './app.component';
import { TokenInterceptor } from './interceptor/token.interceptor';
import { ErrorsModule } from './errors/errors.module';
import { CoreModule } from './core/core.module';
import { UsuarioModule } from './usuarios/usuario.module';
import { GruposModule } from './grupos/grupo.module';
import { MensagensModule } from './mensagens/mensagens.module';

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule, 
    MaterializeModule,
    AppRoutingModule,
    ErrorsModule,
    CoreModule,
    VMessageModule,
    UsuarioModule,
    GruposModule,
    MensagensModule
  ],
  exports: [
    CoreModule,
    MaterializeModule,
    VMessageModule
  ],
  providers: [
    {provide: HTTP_INTERCEPTORS, useClass: TokenInterceptor, multi: true }
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }

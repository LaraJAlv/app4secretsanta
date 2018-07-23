import { NgModule } from '@angular/core';
import { HttpClientModule } from '@angular/common/http';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { SocialLoginModule, AuthServiceConfig, FacebookLoginProvider } from "angular-6-social-login";

import { CoreModule } from '../core/core.module';
import { UsuarioComponente } from './usuario/usuario.component';
import { LoginComponent } from './login/login.component';
import { ConviteComponent } from './convite/convite.component';
import { MenuComponent } from '../core/menu/menu.component';

// Configs 
export function getAuthServiceConfigs() {
  let config = new AuthServiceConfig(
    [{
      id: FacebookLoginProvider.PROVIDER_ID,
      provider: new FacebookLoginProvider("1991939587693441")
    }]
  );
  return config;
}

@NgModule({
  declarations: [
    UsuarioComponente,
    LoginComponent,
    ConviteComponent
  ],
  imports: [
    HttpClientModule,
    SocialLoginModule,
    CommonModule,
    RouterModule,
    CoreModule
  ],
  providers: [
    {
      provide: AuthServiceConfig,
      useFactory: getAuthServiceConfigs
    }
  ],
  bootstrap: [UsuarioComponente]
})
export class UsuarioModule { }
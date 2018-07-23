import { Component, OnInit } from '@angular/core';
import { AuthService, FacebookLoginProvider } from 'angular-6-social-login';
import { Router } from '@angular/router';

import { Usuario } from '../usuario';
import { UsuarioService } from '../usuario.service';

@Component({
  templateUrl: './login.component.html'
})

export class LoginComponent implements OnInit {

  constructor( 
    private socialAuthService : AuthService,
    private usuarioService : UsuarioService,
    private router: Router,
  ) { }

  ngOnInit() {  }

  public socialSignIn(socialPlatform : string) {

    let socialPlatformProvider;
    if (socialPlatform == "facebook") {
      socialPlatformProvider = FacebookLoginProvider.PROVIDER_ID;
    }
    
    this.socialAuthService.signIn(socialPlatformProvider).then(
      (userData) => {
        var usuario: Usuario = {
          CD_Usuario : userData.id,
          CD_Token: userData.token,
          nm_Usuario : userData.name,
          nm_Email : userData.email,
          nm_Imagem : userData.image,
        }

        this.usuarioService.autenticate(usuario)
          .subscribe(
            () => this.router.navigate(['acesso']),
            err => console.log(err)
          );
            
      }
    );
  }
}

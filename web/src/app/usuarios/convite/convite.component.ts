import { Component, OnInit } from '@angular/core';
import { AuthService, FacebookLoginProvider } from 'angular-6-social-login';
import { Router, ActivatedRoute } from '@angular/router';
import { isDefined } from '@angular/compiler/src/util';

import { Usuario } from '../usuario';
import { UsuarioService } from '../usuario.service';
import { Grupo } from './../../grupos/grupo';
import { GrupoService } from './../../grupos/grupo.service';

@Component({
  templateUrl: './convite.component.html'
})

export class ConviteComponent implements OnInit {

    private grupo: Grupo = { ID_Grupo: 0, nm_Grupo: '', tx_Grupo: '' }
    private usuario: Usuario = { CD_Usuario: '', nm_Usuario: '', nm_Imagem: '', nm_Email: '' }
    private authcode: string = '';

  constructor( 
    private socialAuthService : AuthService,
    private usuarioService : UsuarioService,
    private grupoService : GrupoService,
    private activatedRoute: ActivatedRoute,
    private router: Router,
  ) { }

  ngOnInit() {
    const usuario: string = (!isDefined(this.activatedRoute.snapshot.params.user)) ? '' : this.activatedRoute.snapshot.params.user;
    const grupo: number = (!isDefined(this.activatedRoute.snapshot.params.id)) ? 0 : this.activatedRoute.snapshot.params.id;

    /* buscar informações do usuario que enviou o convite */
    this.usuarioService.profile(usuario)
        .subscribe (
            res => this.usuario = res as Usuario,
            err => console.log(err)
        );

    /* buscar dados do grupo referente ao convite */
    this.grupoService.get(grupo, usuario)
        .subscribe(
            res => { this.grupo = res as Grupo; },
            err => console.log(err)
        );
  }

  public register() {
    this.authcode = this.usuarioService.get_code();

    /* verifica se o usuário está logado - se não faz o cadastro/login */
    if (!isDefined(this.authcode)) {
        this.socialSignIn('facebook');
    } else {
      /* insere usuario no grupo */
      this.registerGroup();
    }
  }

  public socialSignIn(socialPlatform : string) {

    let socialPlatformProvider;
    if (socialPlatform == "facebook") {
      socialPlatformProvider = FacebookLoginProvider.PROVIDER_ID;
    }
    
    this.socialAuthService.signIn(socialPlatformProvider).then(
      (userData) => {
        var usuario_logado: Usuario = {
          CD_Usuario : userData.id,
          CD_Token: userData.token,
          nm_Usuario : userData.name,
          nm_Email : userData.email,
          nm_Imagem : userData.image,
        }

        console.log(usuario_logado);

        this.usuarioService.autenticate(usuario_logado)
          .subscribe(
            () => this.registerGroup(),
            err => console.log(err)
          );
            
      }
    );
  }

  private registerGroup() {
    const codigo = this.usuarioService.get_code();
    this.usuarioService.participate(this.grupo.ID_Grupo)
      .subscribe(
          () => this.router.navigate(['grupos/dados/' + this.grupo.ID_Grupo]),
          err => console.log(err)
      );
  }
}

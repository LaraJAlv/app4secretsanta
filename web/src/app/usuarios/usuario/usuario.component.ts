import { Component, OnInit, Input } from '@angular/core';

import { UsuarioService } from '../usuario.service';
import { Usuario } from '../usuario';

@Component ({
    selector: 'ss-usuario',
    templateUrl: './usuario.component.html',
    styleUrls: ['./usuario.component.css']
})

export class UsuarioComponente implements OnInit {

    usuario : Usuario = {
        CD_Usuario: '',
        CD_Token: '',
        nm_Usuario: '',
        nm_Email: '',
        nm_Imagem: '',
    };

    constructor( 
      private usuarioService : UsuarioService
    ) { }

    ngOnInit() {  
        this.usuarioService.profile()
            .subscribe(
                res_usuario => { this.usuario = res_usuario as Usuario; },
                err => console.log(err)
            );
    }
    
}
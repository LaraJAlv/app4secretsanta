import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { BehaviorSubject } from 'rxjs';

import { environment } from '../../environments/environment';
import { AuthService } from '../core/auth/auth.service';
import { Mensagem } from './mensagem';

@Injectable({
    providedIn: 'root'
})

export class MensagemService {

    private mensagem = new BehaviorSubject<Mensagem>(null);

    constructor(
        private http : HttpClient,
        private authService : AuthService
    ) { }

    list () {
        var CD_Usuario : string = this.authService.getUserCode();
        return this.http
            .get(environment.api_url + 'mensagens/' + CD_Usuario);
    }

    get (CD_UsuarioDestino: string, fl_Anonimo: number) {
        var CD_Usuario : string = this.authService.getUserCode();
        return this.http
            .post(environment.api_url + 'mensagens/seleciona', { 'CD_Usuario' : CD_Usuario , 'CD_UsuarioDestino' : CD_UsuarioDestino , 'fl_Anonimo' : fl_Anonimo });
    }

    save (mensagem: Mensagem) {
        var CD_Usuario : string = this.authService.getUserCode();
        mensagem.CD_Usuario = CD_Usuario;
        return this.http
            .post(environment.api_url + 'mensagens', mensagem);
    }

}



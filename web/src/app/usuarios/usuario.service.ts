import { isDefined } from '@angular/compiler/src/util';
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { BehaviorSubject } from 'rxjs';
import { tap } from "rxjs/operators";

import { environment } from '../../environments/environment';
import { AuthService } from '../core/auth/auth.service';
import { Usuario } from "./usuario";

@Injectable({
    providedIn: 'root'
})

export class UsuarioService {

    private usuario = new BehaviorSubject<Usuario>(null);

    constructor(
        private http : HttpClient,
        private authService : AuthService
    ) { }

    autenticate (usuario: Usuario) {
        return this.http
            .post(environment.api_url + 'usuario', usuario)
            .pipe(
                tap (res => {
                    this.authService.setToken(res as string);
                })
            );
    }

    profile (CD_Usuario?: string) {
        if (!isDefined(CD_Usuario)) {
            var CD_Usuario : string = this.authService.getUserCode();
        }
        return this.http
            .get(environment.api_url + 'usuario/' + CD_Usuario);
    }

    participate (ID_Grupo: number) {
        var CD_Usuario : string = this.authService.getUserCode();
        return this.http
            .post(environment.api_url + 'participantes', { 'CD_Usuario': CD_Usuario, 'ID_Grupo': ID_Grupo });
    }

    get_code () {
        return this.authService.getUserCode();
    }
}



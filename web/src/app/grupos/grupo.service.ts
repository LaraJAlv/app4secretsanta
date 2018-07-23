import { isDefined } from '@angular/compiler/src/util';
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { BehaviorSubject } from 'rxjs';

import { environment } from '../../environments/environment';
import { AuthService } from '../core/auth/auth.service';
import { Grupo } from "./grupo";

@Injectable({
    providedIn: 'root'
})

export class GrupoService {

    private grupo = new BehaviorSubject<Grupo>(null);

    constructor(
        private http : HttpClient,
        private authService : AuthService
    ) { }

    get (ID_Grupo: number, CD_Usuario?: string) {
        if (!isDefined(CD_Usuario)){
            var CD_Usuario : string = this.authService.getUserCode();
        }
        return this.http
            .get(environment.api_url + 'grupos/' + CD_Usuario + '/' + ID_Grupo);
    }

    list () {
        var CD_Usuario : string = this.authService.getUserCode();
        return this.http
            .get(environment.api_url + 'grupos/' + CD_Usuario);
    }

    save (grupo: Grupo) {
        var CD_Usuario : string = this.authService.getUserCode();
        grupo.CD_Usuario = CD_Usuario;
        return this.http
            .post(environment.api_url + 'grupos', grupo);
    }

    delete (ID_Grupo: number) {
        var CD_Usuario : string = this.authService.getUserCode();
        return this.http
            .delete(environment.api_url + 'grupos/' + CD_Usuario + '/' + ID_Grupo);
    }

    get_code () {
        return this.authService.getUserCode();
    }

}



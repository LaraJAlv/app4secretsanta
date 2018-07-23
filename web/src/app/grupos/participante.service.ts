import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { BehaviorSubject } from 'rxjs';

import { environment } from '../../environments/environment';
import { AuthService } from '../core/auth/auth.service';
import { Participante, Dica } from "./participante";

@Injectable({
    providedIn: 'root'
})

export class ParticipanteService {

    private participante = new BehaviorSubject<Participante>(null);

    constructor(
        private http : HttpClient,
        private authService : AuthService
    ) { }

    list (ID_Grupo: number) {
        var CD_Usuario : string = this.authService.getUserCode();
        return this.http
            .get(environment.api_url + 'participantes/' + CD_Usuario + '/' + ID_Grupo);
    }

    delete (ID_Grupo: number, ID_Usuario: number) {
        if (ID_Usuario == 0) {
            ID_Usuario = this.authService.getUserId();
        }
        var CD_Usuario : string = this.authService.getUserCode();
        return this.http
        .delete(environment.api_url + 'participantes/' + CD_Usuario + '/' + ID_Grupo + '/' + ID_Usuario);
    }

    owner (ID_Grupo: number, ID_Usuario: number, fl_Propriedade: boolean) {
        var CD_Usuario : string = this.authService.getUserCode();
        return this.http
            .post(environment.api_url + 'participantes/propriedade', {
                'CD_Usuario': CD_Usuario,
                'ID_Grupo': ID_Grupo,
                'ID_Usuario': ID_Usuario,
                'fl_Propriedade': fl_Propriedade,
            });
    }
    
    /* procedimentos referentes ao sorteio de amigos */
    sort (ID_Grupo: number) {
        var CD_Usuario : string = this.authService.getUserCode();
        return this.http
            .post(environment.api_url + 'sorteio', { 'CD_Usuario': CD_Usuario , 'ID_Grupo': ID_Grupo});
    }

    sort_get (ID_Grupo: number) {
        var CD_Usuario : string = this.authService.getUserCode();
        return this.http
            .get(environment.api_url + 'sorteio/' + CD_Usuario + '/' + ID_Grupo);
    }

    sort_delete (ID_Grupo: number) {
        var CD_Usuario : string = this.authService.getUserCode();
        return this.http
            .delete(environment.api_url + 'sorteio/' + CD_Usuario + '/' + ID_Grupo);
    }

    /* procedimentos referentes as dicas de presente */
    dica_get(ID_Grupo: number) {
        var CD_Usuario : string = this.authService.getUserCode();
        return this.http
            .get(environment.api_url + 'dicas/' + CD_Usuario + '/' + ID_Grupo);
    }

    dica_save(dica: Dica) {
        var CD_Usuario : string = this.authService.getUserCode();
        dica.CD_Usuario = CD_Usuario;
        return this.http
            .post(environment.api_url + 'dicas', dica);
    }

}



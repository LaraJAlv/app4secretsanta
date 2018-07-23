import { Component, OnInit, Input, Output } from '@angular/core';
import { Router } from '@angular/router';

import { Grupo, GrupoRetorno } from './../grupo';
import { GrupoService } from '../grupo.service';
import { ParticipanteService } from './../participante.service';

@Component({
    templateUrl: './grupo-lista.component.html'
})

export class GrupoListaComponent implements OnInit {

    grupos: Grupo[] = [];
    al_grupos: Grupo[] = [];
    nm_Grupo: string = '';

    constructor(
        private grupoService: GrupoService,
        private participanteService: ParticipanteService,
        private router: Router,
    ) { }

    ngOnInit(): void {
        /* listagem de grupos */
        this.grupoService
            .list()
            .subscribe(
                grupos => { 
                    this.al_grupos = grupos as Grupo[]; 
                    this.filter(this.nm_Grupo);
                },
                err => console.log(err)
            );
    }

    private filter (filtro: string) {
        this.nm_Grupo = filtro;
        this.grupos = this.al_grupos.filter(grupo => 
            grupo.nm_Grupo.toLowerCase().includes(this.nm_Grupo)
        )        
    }

    private edit (grupo: Grupo) {
        this.router.navigate(['/grupos/form/' + grupo.ID_Grupo])
    }

    private detail (grupo: Grupo) {
        this.router.navigate(['/grupos/dados/' + grupo.ID_Grupo])
    }

    private sort (grupo: Grupo) {
        this.participanteService
            .sort(grupo.ID_Grupo)
            .subscribe(
                res => {
                    var retorno: GrupoRetorno = res as GrupoRetorno;
                    this.router.navigate(['/grupos/dados/'+retorno.ID_Grupo])
                },
                err => console.log(err)
            );
    }
    
    private delete (grupo: Grupo) {
        if (confirm("Confirma a exclusão do grupo " + grupo.nm_Grupo + " e todos os seus dados?")) {
            this.grupoService
                .delete(grupo.ID_Grupo)
                .subscribe(
                    res => {
                        this.al_grupos.splice(this.al_grupos.indexOf(grupo), 1);
                        this.filter(this.nm_Grupo);
                    },
                    err => console.log(err)
                );
        }
    }
    
}
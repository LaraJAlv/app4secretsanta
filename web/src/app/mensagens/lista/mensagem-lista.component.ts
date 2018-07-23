import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';

import { Mensagem } from './../mensagem';
import { MensagemService } from '../mensagem.service';

@Component({
  templateUrl: './mensagem-lista.component.html',
})

export class MensagemListaComponent implements OnInit {

  mensagens: Mensagem[] = [];
  al_mensagens: Mensagem[] = [];
  nm_Usuario: string = '';

  constructor(
    private mensagemService: MensagemService,
    private activatedRoute: ActivatedRoute,
    private router: Router
  ) { }

  ngOnInit() {
    /* listagem de mensagens */
    this.mensagemService
      .list()
      .subscribe(
          mensagens => { 
            this.al_mensagens = mensagens as Mensagem[]; 
            this.filter(this.nm_Usuario);
          },
          err => console.log(err)
      );
  }

  private filter (filtro: string) {
    this.nm_Usuario = filtro;
    this.mensagens = this.al_mensagens.filter(mensagem => 
      mensagem.nm_Usuario.toLowerCase().includes(this.nm_Usuario)
    )        
  }

  private open (mensagem: Mensagem) {
    this.router.navigate(['/mensagens/' + mensagem.fl_Anonimo + '/' + mensagem.CD_Usuario])
  }

}

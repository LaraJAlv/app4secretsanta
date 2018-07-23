import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { isDefined } from '@angular/compiler/src/util';

import { Mensagem } from './../mensagem';
import { Usuario } from './../../usuarios/usuario';
import { UsuarioService } from './../../usuarios/usuario.service';
import { MensagemService } from '../mensagem.service';

@Component({
  templateUrl: './mensagem-dados.component.html',
})

export class MensagemDadosComponent implements OnInit {

  usuario : Usuario = {
    CD_Usuario: '',
    nm_Usuario: '',
    nm_Email: '',
    nm_Imagem: '',
  };
  mensagem : Mensagem = {
    tx_Mensagem: ''
  }
  mensagens : Mensagem[] = [];
  mensagemForm: FormGroup;

  constructor(
    private formBuilder: FormBuilder,
    private activatedRoute: ActivatedRoute,
    private usuarioService: UsuarioService,
    private mensagemService: MensagemService,
    private router: Router
  ) { }

  ngOnInit() {
    /* inicia o formulario */
    this.mensagemForm = this.formBuilder.group({
      tx_Mensagem: ['', Validators.required],
    });

    this.mensagem.CD_UsuarioDestino = (!isDefined(this.activatedRoute.snapshot.params.user)) ? '' : this.activatedRoute.snapshot.params.user;
    this.mensagem.fl_Anonimo = ((!isDefined(this.activatedRoute.snapshot.params.anonimo)) ? 0 : this.activatedRoute.snapshot.params.anonimo) as boolean;

    /* buscar informações do usuario que enviou o convite */
    this.usuarioService
      .profile(this.mensagem.CD_UsuarioDestino)
      .subscribe (
          res => this.usuario = res as Usuario,
          err => console.log(err)
      );
    
    /* listagem de mensagens da conversa */
    this.mensagemService
      .get(this.mensagem.CD_UsuarioDestino,this.mensagem.fl_Anonimo)
      .subscribe(
          res => this.mensagens = res as Mensagem[],
          err => console.log(err)
      );
  }

  /* faz o envio de mensagens */
  save() {
    var mensagem_insert: Mensagem = this.mensagemForm.value as Mensagem;
    this.mensagem.tx_Mensagem = mensagem_insert.tx_Mensagem;

    this.mensagemService
      .save(this.mensagem)
      .subscribe(
          res => {
            mensagem_insert = res as Mensagem;
            this.mensagens.push(mensagem_insert);
            this.mensagemForm.reset();
          },
          err => console.log(err)
      );
  }

}

import { Component, OnInit, Input } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { isDefined } from '@angular/compiler/src/util';

import { Grupo, GrupoRetorno } from './../grupo';
import { Participante, Dica } from './../participante';
import { GrupoService } from '../grupo.service';
import { ParticipanteService } from '../participante.service';

@Component({
  templateUrl: './grupo-dados.component.html'
})
export class GrupoDadosComponent implements OnInit {

  grupo: Grupo = { ID_Grupo: 0, nm_Grupo: '', tx_Grupo: '' };
  CD_Usuario: string = '';

  dica: Dica = { tx_Dica: '', nm_Link: '' };
  dicaForm: FormGroup;

  participante: Participante = { ID_Usuario: 0, nm_Usuario: '', nm_Imagem: '' };

  participantes: Participante[] = [];
  al_participantes: Participante[] = [];
  nm_Usuario: string = '';

  public popoverTitle: string = 'Confirma a remoção deste participante?';
  public popoverMessage: string = 'Ao remover este participante ele não participará mais do sorteio do amigo oculto';
  public confirmClicked: boolean = false;
  public cancelClicked: boolean = false;

  constructor(
    private formBuilder: FormBuilder,
    private grupoService: GrupoService,
    private participanteService: ParticipanteService,
    private activatedRoute: ActivatedRoute,
    private router: Router,
  ) { }
  
  ngOnInit() { 
    /* busca codigo de usuario logado */
    this.CD_Usuario = this.grupoService.get_code();
    
    /* inicia o formulario */
    this.dicaForm = this.formBuilder.group({
      tx_Dica: ['', Validators.required],
      nm_Link: [''],
    });

    /* busca dados do grupo selecionado para preencher os dados principais */
    var codigo: number = this.activatedRoute.snapshot.params.id;
    this.grupoService
      .get(codigo)
      .subscribe(
          res => {
            this.grupo = res as Grupo

            if (isDefined(this.grupo.dt_Sorteio)) {
              /* busca dados do amigo sorteado e dicas de presente passados por ele */
              this.busca_participante();
            }
          },
          err => console.log(err)
      );
    
    /* busca dica de presente cadastrado pelo usuario logado */
    this.participanteService
      .dica_get(codigo)
      .subscribe(
        res => {
          this.dica = res as Dica;
          this.dicaForm.get('tx_Dica').setValue(this.dica.tx_Dica);
          this.dicaForm.get('nm_Link').setValue(this.dica.nm_Link);
        },
        err => console.log(err)
      );
        
    /* lista participantes do grupo */
    this.participanteService
      .list(codigo)
      .subscribe(
        usuarios => { 
              this.al_participantes = usuarios as Participante[]; 
              this.filter(this.nm_Usuario);
          },
          err => console.log(err)
      );
  }

  private filter (filtro: string) {
    this.nm_Usuario = filtro;
    this.participantes = this.al_participantes.filter(usuario => 
      usuario.nm_Usuario.toLowerCase().includes(this.nm_Usuario)
    )        
  }

  private delete (participante: Participante) {
    if(confirm("Confirma a remoção do integrante " + participante.nm_Usuario + " deste grupo?")) {
      this.participanteService
        .delete(this.grupo.ID_Grupo, participante.ID_Usuario)
        .subscribe(
            res => {
                this.al_participantes.splice(this.al_participantes.indexOf(participante), 1);
                this.filter(this.nm_Usuario);
            },
            err => console.log(err)
        );
    }
  }

  private user_delete (participante: Participante) {
    if(confirm("Confirma sua saída deste grupo?")) {
      this.participanteService
        .delete(this.grupo.ID_Grupo, 0)
        .subscribe(
            () => this.router.navigate(['/grupos']),
            err => console.log(err)
        );
    }
  }
  
  private save() {
    this.dica = this.dicaForm.value as Dica;
    this.dica.ID_Grupo = this.grupo.ID_Grupo;

    this.participanteService
      .dica_save(this.dica)
      .subscribe(
          res => {
            this.dica = res as Dica;
            alert('Dica salva com sucesso!')
          },
          err => console.log(err)
      );
  }

  private busca_participante () {
    this.participanteService
      .sort_get(this.grupo.ID_Grupo)
      .subscribe(
        res => this.participante = res as Participante,
        err => console.log(err)
      );
  }

  private message (participante: Participante, anonimo?: number) {
    anonimo = isDefined(anonimo) ? anonimo : 0;
    this.router.navigate(['/mensagens/' + anonimo + '/' + participante.CD_Usuario]);
  }

  /* funções relativas ao sorteio */
  private sort () {
    this.participanteService
        .sort(this.grupo.ID_Grupo)
        .subscribe(
            res => {
              var retorno: GrupoRetorno = res as GrupoRetorno;
              this.grupo.dt_Sorteio = retorno.dt_Sorteio;
              this.busca_participante();
            },
            err => console.log(err)
        );
  }

  private sort_delete () {
    if (confirm("Confirma a exclusão dos dados de sorteio deste amigo oculto?")) {
      this.participanteService
        .sort_delete(this.grupo.ID_Grupo)
        .subscribe(
          res => {
            this.grupo.dt_Sorteio = null;
            this.participante = { ID_Usuario: 0, nm_Usuario: '', nm_Imagem: '' };
          },
          err => console.log(err)
        );
    }
  }

  /* funções relativas a propriedade do grupo */
  private owner_delete (participante: Participante) {
    if (confirm("Confirma remoção de direitos de propriedade de " + participante.nm_Usuario)) {
      this.participanteService
        .owner(this.grupo.ID_Grupo, participante.ID_Usuario, false)
        .subscribe(
          res => {
            var index = this.al_participantes.indexOf(participante);
            this.al_participantes[index].fl_Proprietario = false;
            this.filter(this.nm_Usuario);
            console.log(index);
          },
          err => console.log(err)
        );
    }
  }

  private owner_set (participante: Participante) {
    if (confirm("Confirma adição de direitos de propriedade de " + participante.nm_Usuario)) {
      this.participanteService
        .owner(this.grupo.ID_Grupo, participante.ID_Usuario, true)
        .subscribe(
          res => {
            var index = this.al_participantes.indexOf(participante);
            this.al_participantes[index].fl_Proprietario = true;
            this.filter(this.nm_Usuario);
            console.log(index);
          },
          err => console.log(err)
        );
    }
  }
}

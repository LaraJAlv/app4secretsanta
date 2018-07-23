import { Component, OnInit, Input } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { isDefined } from '@angular/compiler/src/util';
import { empty } from 'rxjs';

import { Grupo } from '../grupo';
import { GrupoService } from '../grupo.service';

@Component({
  templateUrl: './grupo-form.component.html'
})

export class GrupoFormComponent implements OnInit {

  grupo: Grupo = {
    ID_Grupo: 0,
    nm_Grupo: '',
    tx_Grupo: ''
  };
  grupoForm: FormGroup;
  private ID_Grupo: number;

  constructor(
    private formBuilder: FormBuilder,
    private grupoService: GrupoService,
    private activatedRoute: ActivatedRoute,
    private router: Router
  ) { }
  
  ngOnInit() {
    this.grupoForm = this.formBuilder.group({
      nm_Grupo: ['', Validators.required],
      tx_Grupo: ['', Validators.required],
    });

    /* pega id do grupo e busca dados para preencher o formulario */
    this.ID_Grupo = (!isDefined(this.activatedRoute.snapshot.params.id)) ? 0 : this.activatedRoute.snapshot.params.id;
    if (this.ID_Grupo > 0) {
      this.grupoService
        .get(this.ID_Grupo)
        .subscribe(
            res => {
              this.grupo = res as Grupo;
              this.grupoForm.get('nm_Grupo').setValue(this.grupo.nm_Grupo);
              this.grupoForm.get('tx_Grupo').setValue(this.grupo.tx_Grupo);
            },
            err => console.log(err)
        );
    }
  }
  
  save() {
    this.grupo = this.grupoForm.value as Grupo;
    this.grupo.ID_Grupo = this.ID_Grupo;

    this.grupoService
        .save(this.grupo)
        .subscribe(
            res => {
              var codigo: number = res as number;
              this.router.navigate(['/grupos/dados/' + codigo])
            },
            err => console.log(err)
        );
  }

}

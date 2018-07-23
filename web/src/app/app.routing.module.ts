import { AuthGuard } from './core/auth/auth.guard';
import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { AberturaComponent } from './core/abertura/abertura.component';
import { NotfoundComponent } from './errors/notfound/notfound.component';
import { LoginComponent } from './usuarios/login/login.component';
import { UsuarioComponente } from './usuarios/usuario/usuario.component';
import { ConviteComponent } from './usuarios/convite/convite.component';
import { GrupoListaComponent } from './grupos/lista/grupo-lista.component';
import { GrupoFormComponent } from './grupos/form/grupo-form.component';
import { GrupoDadosComponent } from './grupos/dados/grupo-dados.component';
import { MensagemListaComponent } from './mensagens/lista/mensagem-lista.component';
import { MensagemDadosComponent } from './mensagens/dados/mensagem-dados.component';

const appRoutes: Routes = [
    { path: '', component: AberturaComponent },

    /* rotas de acesso iniciais */
    { path: 'login', component: LoginComponent },
    { path: 'convite/:user/:id', component: ConviteComponent },
    { path: 'acesso', component: UsuarioComponente , canActivate: [ AuthGuard ] },

    /* rotas referentes aos grupos de amigos */
    { path: 'grupos', component: GrupoListaComponent , canActivate: [ AuthGuard ] },
    { path: 'grupos/form', component: GrupoFormComponent , canActivate: [ AuthGuard ] },
    { path: 'grupos/form/:id', component: GrupoFormComponent , canActivate: [ AuthGuard ] },
    { path: 'grupos/dados', component: GrupoDadosComponent , canActivate: [ AuthGuard ] },
    { path: 'grupos/dados/:id', component: GrupoDadosComponent , canActivate: [ AuthGuard ] },

    /* rotas referentes as mensagens de amigos */
    { path: 'mensagens', component: MensagemListaComponent , canActivate: [ AuthGuard ] },
    { path: 'mensagens/:user', component: MensagemDadosComponent , canActivate: [ AuthGuard ] },
    { path: 'mensagens/:user/:anonimo', component: MensagemDadosComponent , canActivate: [ AuthGuard ] },

    /* tratamento de erros de rota */
    { path: '**', component: NotfoundComponent }
]

@NgModule({
    imports: [ 
        RouterModule.forRoot(appRoutes) 
    ],
    exports: [ RouterModule ]
})

export class AppRoutingModule { }
import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';
import * as jtw_decode from 'jwt-decode';

import { Auth } from './auth';
import { TokenService } from '../token/token.service';

@Injectable({ providedIn: 'root'})

export class AuthService { 

    private userSubject = new BehaviorSubject<Auth>(null);
    private userCode: string;
    private userId: number;

    constructor(private tokenService: TokenService) { 

        this.tokenService.hasToken() && 
            this.decodeAndNotify();
    }

    setToken(token: string) {
        this.tokenService.setToken(token);
        this.decodeAndNotify();
    }

    getAuth() {
        return this.userSubject.asObservable();
    }

    private decodeAndNotify() {
        const token = this.tokenService.getToken();
        const user = jtw_decode(token) as Auth;
        user.nm_Avatar = user.nm_Usuario.split(' ')[0];
        this.userCode = user.CD_Usuario;
        this.userId = user.ID_Usuario;
        this.userSubject.next(user);
    }

    logout() {
        this.tokenService.removeToken();
        this.userSubject.next(null);
    }

    isLogged() {
        return this.tokenService.hasToken();
    }

    getUserCode() {
        return this.userCode;
    }

    getUserId() {
        return this.userId;
    }
}
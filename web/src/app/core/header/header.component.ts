import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { Observable } from 'rxjs';

import { Auth } from '../auth/auth';
import { AuthService } from '../auth/auth.service';

@Component({
    selector: 'ss-header',
    templateUrl: './header.component.html'
})
export class HeaderComponent { 

    auth$: Observable<Auth>;

    constructor(
        private authService: AuthService, 
        private router:Router) {

        this.auth$ = authService.getAuth();
    }

    logout() {
        this.authService.logout();
        this.router.navigate(['']);
    }
}
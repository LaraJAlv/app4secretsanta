import { Component, Input } from '@angular/core';

@Component({
    selector: 'sd-vmessage',
    templateUrl: './vmessage.component.html'
})
export class VMessageComponent {

    @Input() text = '';
 }
import { Component, Input } from '@angular/core';

@Component({
    selector: 'sd-card',
    templateUrl: './card.component.html'
})
export class CardComponent { 
    @Input() title: string = '';
}
import { LightningElement, track } from 'lwc';

export default class HelloGreatings extends LightningElement {
    @track bindingGretting = 'World';
    @track CityList = ['Jaipr','Delhi','Mumbai'];

    onchangegretting(event){
        this.bindingGretting = event.target.value;
    }
}
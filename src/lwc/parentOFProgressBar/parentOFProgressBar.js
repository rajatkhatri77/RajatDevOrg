import { LightningElement, api } from 'lwc';

export default class ParentOFProgressBar extends LightningElement {


    percentage = 50;

    handelPercentage(event){
        this.percentage = event.target.value;
    }
}
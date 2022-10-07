import { LightningElement, wire } from 'lwc';
import getRecordsFromSobjects from '@salesforce/apex/LwcComponent.getRecordsOfSobjects';  

export default class RecordsDisplayingInLightningCOmponent extends LightningElement {
    searchsobj;
    currOutput

    @wire(getRecordsFromSobjects, {sobjName: '$sobjName'}) sobjects;
    handlekeyChange(event){
        window.clearTimeout(this.delayTimeout);
        const searchsobj = event.target.value;
        this.currOutput= event.target.value;
        this.delayTimeout = setTimeout(() => {this.searchsobj = searchsobj;},1000); 
    }


}
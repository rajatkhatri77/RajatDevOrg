import { LightningElement,api } from 'lwc';
import getContactRecords from '@salesforce/apex/LwcComponent.getContactRecords';

export default class ChildAssignment2 extends LightningElement {


    contacts;
    error;
    @api
    handlerload(){
        getContactRecords()
            .then((result) =>{
                this.contacts=result;
                this.error=undefined;
            })

            .catch((error) =>{
                this.error=error;
                this.contacts=undefined;
            });
    }
}
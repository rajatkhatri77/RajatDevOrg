import { LightningElement } from 'lwc';
import {NavigationMixin} from 'lightning/navigation';

export default class NavNewContact extends NavigationMixin(LightningElement) {
    navtonewcontact(){
        this[NavigationMixin.Navigate]({
        type: 'standard__objectPage',
        attributes:{
            objectApiName: 'Contact',
            actionName: 'new'
        }
        });
    }
    
}
import { LightningElement, wire } from 'lwc';
import {NavigationMixin } from 'lightning/navigation';
import getSingleAccount from '@salesforce/apex/Assignment3LWC.getSingleAccount';

export default class NavigateToRelatedList extends NavigationMixin(LightningElement) {

    @wire(getSingleAccount)acc;

    navigateToRelatedList(){
        this[NavigationMixin.Navigate]({
            type: 'standard__recordRelationshipPage',
        attributes:{
            recordId: this.acc.data.Id,
            objectApiNmae: 'Account',
            relationshipApiName: 'Contacts',
            actionName: 'view'

        }
        
        });
    }
}
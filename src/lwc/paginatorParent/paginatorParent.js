import { LightningElement, track, wire } from 'lwc';
import getContactRecords from '@salesforce/apex/LwcComponent.getContactRecords';

export default class PaginatorParent extends LightningElement {
    visibleContacts;
    totalContacts;
    error;
    columns=[
        { label: 'Name', fieldName: 'Name', type: 'text' },
        { label: 'Phone', fieldName: 'Phone', type: 'phone' },
        { label: 'Email', fieldName: 'Email', type: 'email' }
    ];

    @wire(getContactRecords)
    wireContacts({error, data}){
        if(data){
            this.totalContacts=data;
            this.error=undefined;
        }
        if(error){
            this.error=error;
            this.totalContacts=undefined;
        } 
    }
    updatecall(event){
        this.visibleContacts=[...event.detail.allrecords]
        console.log(event.detail.allrecords)
    }
}
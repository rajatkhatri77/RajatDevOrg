import { LightningElement, wire,track } from 'lwc';
import getContactRecords from '@salesforce/apex/LwcComponent.getContactRecords';


export default class ParentEventWithData extends LightningElement {


    @track selectedContact;
    @wire(getContactRecords) contacts;


    handleSelect(event) {
        const contactId = event.detail;
        this.selectedContact = this.contacts.data.find(
            (contact) => contact.Id === contactId
        );
    }
}
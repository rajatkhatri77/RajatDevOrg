import { LightningElement, wire } from 'lwc';
import getingContactRecords from '@salesforce/apex/LwcComponentContacts.getingContactRecords'; 

export default class LwcContactDisplay extends LightningElement {
    @wire(getingContactRecords) contacts;
}
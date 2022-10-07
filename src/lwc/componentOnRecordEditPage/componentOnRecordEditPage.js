import { api, LightningElement, track, wire} from 'lwc';

import getRecordsFromSobjects from '@salesforce/apex/LwcComponent.getRecordsOfSobjects';  

export default class ComponentOnRecordEditPage extends LightningElement {
    @api ComponentHeader;
    @api sobject;
    @track data;
    @track error;
    columns=[
        { label: 'Name', fieldName: 'Name', type: 'text' },
        { label: 'Phone', fieldName: 'Phone', type: 'phone' },
        { label: 'Email', fieldName: 'Email', type: 'email' }
    ];
    


    @wire(getRecordsFromSobjects, {sobjName: '$sobject'}) sobjects;
}
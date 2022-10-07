import { LightningElement, api, track, wire } from 'lwc';

import getRecordsOfOpportunities from '@salesforce/apex/LwcComponent.getRecordsOfOpportunities';  


export default class OpportunitiesRecordWithLC extends LightningElement {
    @api ComponentHeader
    @api sobject;
    @api stage;
    @track data;
    @track error;
    columns=[
        { label: 'Name', fieldName: 'Name', type: 'text' },
        { label: 'stage', fieldName: 'StageName', type: 'text' },
        { label: 'LeadSource', fieldName: 'LeadSource', type: 'text' }
    ];
    


    @wire(getRecordsOfOpportunities, {sobjName: '$sobject', stage: '$stage'})
    sobjects;
}
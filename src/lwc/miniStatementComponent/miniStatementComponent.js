import { LightningElement, wire,track,api } from 'lwc';
import getRecordsTransactionEntries from '@salesforce/apex/MiniStatmentComponentControler.getTransactionEntries';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class miniStatementComponent extends LightningElement {
    @api recId;
    @track transactionEntries=[];
    @track error;
    @track selectedOption = 5;
    _title = 'Error';
    message = 'Something went wrong check your component';
    variant = 'error';
    columns = [
        {label: 'Name', fieldName: 'nameUrl', type: 'url',typeAttributes: {label: { fieldName: 'Name' }, target: '_blank'}},
        {label: 'Amount', fieldName: 'Amount__c', type: 'Decimal'},
        {label: 'Type', fieldName: 'Type__c', type: 'Text'},
        {label: 'Status', fieldName: 'Status__c', type: 'Text'},
    ];
      
    
    changeHandler(event){
        const field = event.target.name;
        if(field === 'optionSelect'){
            this.selectedOption = event.target.value;
          
        }
    }
    @wire(getRecordsTransactionEntries, { recId : '$recId' , selectedOption : '$selectedOption' })
    wiredTxEntries({data, error}){
        if(data){
            let nameUrl;
            this.transactionEntries = data.map(row => { 
                nameUrl = `/${row.Id}`;
                return {...row , nameUrl} 
            })
            window.console.log('data', data);
            window.console.log('transactionEntries', this.transactionEntries);
            this.error = null
        }
        else if(error){
            this.error = error;
            window.console.log('error', error);
            this.result = undefined;
            this.toastError(error, "Mini Statement is unable to retrive data.");
           
        }
    }
    toastError(error, title) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: title,
                message: reduceErrors(error).join(", "),
                variant: "error"
            })
        );
    }
}
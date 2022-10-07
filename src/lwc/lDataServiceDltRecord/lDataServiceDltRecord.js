import { LightningElement, wire } from 'lwc';
import {deleteRecord} from 'lightning/uiRecordApi';
import {refreshApex} from '@salesforce/apex';
import {reduceErrors} from 'c/ldsUtils';
import getAllRecordsOfAccounts from '@salesforce/apex/LwcComponent.getAllRecordsOfAccounts';

export default class LDataServiceDltRecord extends LightningElement {

    accounts;
    error;

    wiredAccountsResult;

    @wire(getAllRecordsOfAccounts)
    wireAccounts(result){
        this.wiredAccountsResult=result;
        if(result.data){
            this.accounts=result.data;
            this.error=undefined;
        }
        else if(result.error){
            this.error=result.error;
            this.accounts=undifined;
        }
    }


    deleteAccount(event) {
        const recordId = event.target.dataset.recordid;
        deleteRecord(recordId)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Account deleted',
                        variant: 'success'
                    })
                );
                return refreshApex(this.wiredAccountsResult);
            })
            .catch((error) => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error deleting record',
                        message: reduceErrors(error).join(', '),
                        variant: 'error'
                    })
                );
            });
    }
}
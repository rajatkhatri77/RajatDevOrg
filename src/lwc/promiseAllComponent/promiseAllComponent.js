import { LightningElement,track } from 'lwc';
import getAccountsRecords from '@salesforce/apex/Assignment3LWC.getRecordsOfAccounts';
import getContactsRecords from '@salesforce/apex/Assignment3LWC.getRecordsOfContacts';
import getOpportunityRecords from '@salesforce/apex/Assignment3LWC.getRecordsOfOpportunity';

export default class PromiseAllComponent extends LightningElement {

    @track accounts;
    @track error;
    @track contacts;
    @track opportunities;

    columnsForContacts = [
        { label: 'Name', fieldName: 'Name', type: 'text' },
        { label: 'Account Name', fieldName: 'Name', type: 'text' },
        { label: 'Created Date', fieldName: 'CreatedDate', type: 'date' },
        { label: 'Email', fieldName: 'Email', type: 'email' }
    ];

    columnsForAccounts = [
        { label: 'Name', fieldName: 'Name', type: 'text' },
        { label: 'Created Date', fieldName: 'CreatedDate', type: 'date' },
        {label: 'BillingStreet', fieldName: 'BillingStreet', type: 'text'},
        {label: 'Record Type', fieldName: 'recordTypeName', type: 'text'}
    ];

    columnsForOpportunities = [
        { label: 'Name', fieldName: 'Name', type: 'text' },
        { label: 'Account Name', fieldName: 'Name', type: 'text' },
        { label: 'Created Date', fieldName: 'CreatedDate', type: 'date' },
    ];

    spinnerForAccount = false;
    spinnerForContact = false;
    spinnerForOpportunities = false;

    _title = 'Error in fetching data from Apex Call';
    message = 'Check Apex Call and promise Handler';
    variant = 'error';

    connectedCallback() {
        this.spinnerForAccount = true;
        this.spinnerForContact = true;
        this.spinnerForOpportunities = true;
        this.allPromise();
    }


    allPromise(){
        console.log('inside allPromise()');
        let promises = [];
        promises.push(this.promiseHelper("methodToCallAccounts"));
        promises.push(this.promiseHelper("methodToCallContacts"));
        promises.push(this.promiseHelper("methodToCallOpportunities"));
        Promise.all(promises).then((result) => {
			this.accounts=result[0];
            this.spinnerForAccount = false;
            this.contacts=result[1];
            this.spinnerForContact = false;
            this.opportunities=result[2];
            this.spinnerForOpportunities = false;
		})
        .catch((error) => {
            this.error=error;
            this.spinnerForAccount = false;
            this.spinnerForContact = false;
            this.spinnerForOpportunities = false;
            const eventPromiseAll = new ShowToastEvent({
                title: this._title,
                message: this.message,
                variant: this.variant,
            });
            this.dispatchEvent(eventPromiseAll);
        })
        
    }


    promiseHelper(methodName) {
        if (methodName == 'methodToCallAccounts') {
            return new Promise((resolve, reject) => {
                getAccountsRecords()
                    .then(result => {
                        resolve(result);
                    })
                    .catch(error => {
                        reject(error);
                    });
            });
        }

        if (methodName == 'methodToCallContacts') {
            return new Promise((resolve, reject) => {
                getContactsRecords()
                    .then(result => {
                        resolve(result);
                    })
                    .catch(error => {
                        reject(error);
                    });
            });
        }

        if (methodName == 'methodToCallOpportunities') {
            return new Promise((resolve, reject) => {
                getOpportunityRecords()
                    .then(result => {
                        resolve(result);
                    })
                    .catch(error => {
                        reject(error);
                    });
            });

        }

    }
}
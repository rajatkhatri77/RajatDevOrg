import { LightningElement, track } from 'lwc';
import getAccountsRecords from '@salesforce/apex/Assignment3LWC.getRecordsOfAccounts';
import getContactsRecords from '@salesforce/apex/Assignment3LWC.getRecordsOfContacts';
import getOpportunityRecords from '@salesforce/apex/Assignment3LWC.getRecordsOfOpportunity';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class PromiseDemo extends LightningElement {
    @track accounts;
    @track error;
    @track contacts;
    @track opportunities;
    @track accountsWithPromise;

    columnsForContacts = [
        { label: 'Name', fieldName: 'sName', type: 'String' },
        { label: 'Account Name', fieldName: 'sAccountName', type: 'String' },
        { label: 'Created Date', fieldName: 'dCreatedDate', type: 'date' },
        { label: 'Email', fieldName: 'sEmail', type: 'String' }
    ];

    columnsForAccounts = [
        { label: 'Name', fieldName: 'sName', type: 'String' },
        { label: 'Created Date', fieldName: 'dCreatedDate', type: 'date' },
        {label: 'BillingStreet', fieldName: 'sBillingStreet', type: 'String'},
        {label: 'Record Type', fieldName: 'sRecordTypeName', type: 'String'}
    ];

    columnsForOpportunities = [
        { label: 'Name', fieldName: 'sName', type: 'String' },
        { label: 'Account Name', fieldName: 'sAccountName', type: 'String' },
        { label: 'Created Date', fieldName: 'dCreatedDate', type: 'String' },
    ];

    // { label: 'Account Name', fieldName: 'Account.Name', type: 'text' },


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
        this.promiseHelper("methodToCallAccounts")
            .then((result) => {
                this.accounts = result;
                this.error = undefined; //toast msg notification on error
                this.spinnerForAccount = false;
                return this.promiseHelper("methodToCallContacts");
            }).then((result) => {
                this.contacts = result;
                this.error = undefined;
                this.spinnerForContact = false;
                return this.promiseHelper("methodToCallOpportunities");
            }).then((result) => {
                this.opportunities = result;
                this.error = undefined;
                this.spinnerForOpportunities = false;
            })
            .catch((error) => {
                this.error = error;
                this.opportunities = undefined;
                this.spinnerForOpportunities = false;
                const eventForToastOpportunities = new ShowToastEvent({
                    title: this._title,
                    message: this.message,
                    variant: this.variant,
                });
                this.dispatchEvent(eventForToastOpportunities);
            })
            .catch((error) => {
                this.error = error;
                this.contacts = undefined;
                this.spinnerForContact = false;
                const eventForToastContacts = new ShowToastEvent({
                    title: this._title,
                    message: this.message,
                    variant: this.variant,
                });
                this.dispatchEvent(eventForToastContacts);
            })
            .catch((error) => {
                this.error = error;
                this.accounts = undefined;
                this.spinnerForAccount = false;
                const eventForToastAccounts = new ShowToastEvent({
                    title: this._title,
                    message: this.message,
                    variant: this.variant,
                });
                this.dispatchEvent(eventForToastAccounts);
            })
            // this.promiseHelper("B")
            // this.promiseHelper("C")


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

    allPromise(){
        console.log('inside allPromise()');
        let promises = [];
        promises.push(this.promiseHelper("methodToCallAccounts"));
        promises.push(this.promiseHelper("methodToCallContacts"));
        promises.push(this.promiseHelper("methodToCallOpportunities"));
        Promise.all(promises).then((result) => {
			this.accountsWithPromise=result[0];
            console.log('this is Accounts Array with promise all');
            console.log(this.accountsWithPromise);
		})
        .catch((error) => {
            this.error=error;
        })
        
    }

}
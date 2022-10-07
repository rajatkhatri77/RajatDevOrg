import { LightningElement, track } from 'lwc';
import getAccountsRecords from '@salesforce/apex/RecordTypeTestControler.getRecordsOfAccountsFromWrapper';


export default class RecordTypeTest extends LightningElement {
    @track accounts;
    @track error;
    @track accountTemp;

    columnsForAccounts = [
        { label: 'Name', fieldName: 'sName', type: 'String' },
        { label: 'Created Date', fieldName: 'dCreatedDate', type: 'date' },
        {label: 'BillingStreet', fieldName: 'sBillingStreet', type: 'String'},
        {label: 'Record Type', fieldName: 'sRecordTypeName', type: 'String'}
    ];


//[SELECT Id, Name, BillingStreet, CreatedDate, RecordType.Name
    connectedCallback(){
        console.log('In RecordType promicehelper');
        this.promiseHelper()
            .then((result) => {
                console.log(result);
                this.accounts = result;
                this.error = undefined;   
            })
            .catch((error) => {
                this.error = error;
                this.accounts = undefined;
                
            })
    }

    promiseHelper(){
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
}

// console.log('connectedCallback() of RecordTypeTest');
//                 console.log(result);
 
//                 let newArray = [];
//                 result.forEach(elementsOfList => {
//                     console.log(elementsOfList);
//                     let newObj = {};
//                     newObj.Id = elementsOfList.Id;
//                     newObj.Name = elementsOfList.Name;
//                     newObj.BillingStreet = elementsOfList.BillingStreet;
//                     newObj.CreatedDate = elementsOfList.CreatedDate;
//                     newObj.recordTypeName = elementsOfList.RecordType.Name;
//                     console.log(newObj);
//                     newArray.push(newObj);
//                 })



// console.log('this is new Array');
//                 console.log(newArray);
//                 this.accounts = newArray;
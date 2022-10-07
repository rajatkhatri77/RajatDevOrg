import { LightningElement,track, wire} from 'lwc';
import getRecordsOfAccounts from '@salesforce/apex/Assignment3LWC.getRecordsOfAccounts';
import getRecordsOfContacts from '@salesforce/apex/Assignment3LWC.getRecordsOfContacts';
import getRecordsOfOpportunity from '@salesforce/apex/Assignment3LWC.getRecordsOfOpportunity';

export default class Assignment3LightningComponent extends LightningElement {

@track accounts;
@track error1;

@track contacts;
@track error2;

@track opportunities;
@track error3;

@track isLoading=false;
@track isLoading1=false;
@track isLoading2=false;

columns=[
    { label: 'Name', fieldName: 'Name', type: 'text' }
]
// @wire(getRecordsOfAccounts)
// wireAccounts({error,data}){
//     if(data){
//         this.accounts=data;
//         this.error=undefined;
//     }
//     else{
//         this.error=error;
//         this.accounts=undefined;
//     }

connectedCallback() {
    this.isLoading = true;
    this.isLoading1 = true;
    this.isLoading2 = true;
    this.invokeApexMethods();
}


invokeApexMethods(){
    getRecordsOfAccounts()
    .then((result) =>{
        
        this.accounts = result;
        this.error1 = undefined;
        //console.log(this.accounts);
        this.isLoading = false;
        getRecordsOfContacts({
            message: result
        })
        .then((result1) => {
            this.contacts = result1;
            this.error2 = undefined;
            //console.log(this.contacts);
            this.isLoading1 = false;
            getRecordsOfOpportunity({
                message: result1
            })
            .then((result2) =>{
                this.opportunities=result2;
                this.error3 = undefined;
                //console.log(this.opportunities);
                this.isLoading2 = false;
            })
            .catch((error) =>{
                this.error3=error;
                this.isLoading2 = false;
            })
        })
        
        .catch((error) => {
            this.error2= error;
            this.isLoading1 = false;
        })
    })
    .catch((erroe) => {
        this.error1 = error;
        this.isLoading = false;
    });
}  
 
    
}
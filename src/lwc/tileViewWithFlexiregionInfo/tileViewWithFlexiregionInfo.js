import { api, LightningElement, track, wire } from 'lwc';
import getContacts from '@salesforce/apex/TileViewWithFlexiregionInfoControler.getRecordsOfContacts';
import { NavigationMixin } from 'lightning/navigation'
import { deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

export default class TileViewWithFlexiregionInfo extends NavigationMixin(LightningElement) {
    @api flexipageRegionWidth;
    @track contacts;
    @track error;
    @track sizeOfcolumn;
    sizeoftile;
    valueOfrecord;
    @api isModalOpen;
    @track actions = [
        {label: 'Edit', value: 'edit', iconName: 'utility:edit'},
        {label: 'Delete', value: 'delete', iconName: 'utility:delete'},
    ];

    // connectedCallback(){
    //     this.sizeee=this.flexipageRegionWidth;
    //     console.log(sizeee);
    // }

   

    renderedCallback(){
        console.log(this.flexipageRegionWidth);
        this.sizeOfcolumn=this.flexipageRegionWidth;
        console.log('inrangercallback: ' +  this.sizeOfcolumn);
        if(this.sizeOfcolumn === 'LARGE'){
            this.sizeoftile=3;
        }
        if(this.sizeOfcolumn === 'SMALL'){
            this.sizeoftile=6;
        }
        if(this.sizeOfcolumn === 'MEDIUM'){
            this.sizeoftile=4;
        }
        console.log('inrangercallback the size of sizeoftile is ' +  this.sizeoftile);



        this.getingContacts()
        .then((result) => {
            
            this.contacts = result;
            this.error = undefined;
        })
        .catch((error) => {
            this.error = error;
            this.contacts = undefined;
        })

    }

    getingContacts(){
        console.log('this is in gettingContacts');
        console.log(this.flexipageRegionWidth);
        return new Promise((resolve, reject) => {
            getContacts()
                .then(result => {
                    resolve(result);
                })
                .catch(error => {
                    reject(error);
                });
        });
    }


    handleAction(event) {
        const tileAction = event.detail.action.label;
        this.valueOfrecord = event.target.dataset.contactid;
        //getFieldValue(this.contactID.data, Contact_ID);
        console.log('this is tileAction: ' + tileAction);
        console.log('this is in handleAction');
        console.log('this is detail.action.id valueOfrecord: ' + this.valueOfrecord);
        if(tileAction === 'Edit'){
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: this.valueOfrecord,
                    objectApiName: 'Contact',
                    actionName: 'edit'
                }
            });
        }

        if(tileAction === 'Delete'){
            this.isModalOpen = true;
        }
    }
    closeModal() {
        this.isModalOpen = false;
    }

    submitDetails() {
        this.isModalOpen = false;
        deleteRecord(this.valueOfrecord)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Record deleted',
                        variant: 'success'
                    })
                );
                return refreshApex(this.contacts);
                // // Navigate to a record home page after
                // // the record is deleted, such as to the
                // // contact home page
                // this[NavigationMixin.Navigate]({
                //     type: 'standard__objectPage',
                //     attributes: {
                //         objectApiName: 'Contact',
                //         actionName: 'home',
                    //},
                //});
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error deleting record',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });

    }
   
}
import { LightningElement, wire, api, track  } from 'lwc';
import fetchData from '@salesforce/apex/GenericRelatedListControler.fetchData';

export default class RelatedListGeneric extends LightningElement {

    @api objectApiName;
    @api recordId;
    @api title;
    @api childobj;
    @api Parentfield;
    @api currentObjRelationToParentObj;
    @api whereClause;
    @api fields;
    columns = [];
    count = 3;
    
    
    //State variable to control rendering the HTML markup
    @track state = {
        initDone: false,
        errorExists : false,
        inlineMessage: null,
        recorddata: [],
        showTable: false
    };
    
    //Getting values of ChildObj,Parentfield,currentObjRelationToParentObj,whereClause,objectApiName and recordId to pass in argument to retrive records of child objects.
    get vals() {
        const { objectApiName, recordId, title, childobj, Parentfield, currentObjRelationToParentObj,whereClause} = this;
        if(typeof this.whereClause !== 'undefined'){
            return childobj + '-' + Parentfield + '-' + currentObjRelationToParentObj + '-' + whereClause + '-'  + objectApiName + '-' + recordId;
        }
        else{
            return this.childobj + '-' + this.Parentfield + '-' + this.currentObjRelationToParentObj + '-NoWhereClause-' + this.objectApiName + '-' +  recordId ;
        }  

    }
    //Getting values of fields to pass in argument.
    get fieldValue(){

        console.log('fields@@@ -> '+this.fields);
        return this.fields;

    }
    get items() {
        let itemArray = [];
        for (let i = 0; i < this.count; i++) {
            itemArray.push(i.toString());
        }

        return itemArray;
    }
    // method to get columns and All records
    @wire(fetchData, { listValues: '$vals' , fieldValues: '$fieldValue'})
    wiredsobjects(result) {

        const { state } = this;

        if (typeof result.data !== 'undefined') {
            
            //Use case when from server side, we have a valid data returned as a result
            if(result.data.size){

                if(result.data.columns){
                    this.columns = result.data.columns;
                    console.log(JSON.stringify(this.columns));
                }
                if(result.data.sobj){
                    console.log(result.data.sobj);
                    /* Prepare the Org Host */
                    let baseUrl = 'https://'+location.host+'/';
                    let dataParse = [];
                    console.log('base url -> ' + baseUrl);
                    for(let i=0; i<result.data.sobj.length; i++){
                        let recs = {};
                        recs.nameUrl = baseUrl + result.data.sobj[i].Id;
                        recs = Object.assign(recs, result.data.sobj[i]);
                        dataParse.push(recs);
                    }

                    state.recorddata = dataParse;
                    state.initDone = true;
                    state.showTable = true;
                    state.errorExists = false;
                    state.inlineMessage = null;
                }

            }
            //Use case when from server side, no data returned as a result
            else{
                state.recorddata= [];
                state.initDone = true;
                state.showTable = false;
                state.errorExists = false;
                state.inlineMessage = result.data.message;

            }
        }
        //Catching unhandled exceptions use case
        else if (typeof result.error !== 'undefined') {
            console.log('error else block');
            state.recorddata= [];
            state.initDone = true;
            state.showTable = false;
            state.errorExists = true;
            state.inlineMessage = '';
        }
    };
}
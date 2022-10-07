import { LightningElement, wire, api, track } from 'lwc';
// import fetchRecords from '@salesforce/apex/GenericRelatedListControler.fetchRecords';
// import fetchColumns from '@salesforce/apex/GenericRelatedListControler.fetchColumns';
import fetchData from '@salesforce/apex/GenericRelatedListControler.fetchData';


export default class RelatedList extends LightningElement {

    @api recordId;
    @api title;
    @api sobject;
    @api Whereclause;
    @api field1;
    @api field2;
    @api field3;
    @api field4;
    columnsfetch = [];
    @track recorddata;
    @track error;
    
    //Getting values of Sobject and Whereclause to pass in argument.
    get vals() {

        return this.recordId + '-' + this.sobject + '-'+ this.Whereclause;

    }
    //Getting values of fields to pass in argument.
    get columnsVals(){
        let fields;

        if(typeof this.field1 !== 'undefined'){
            fields = this.field1 + ',';

        }
        if(typeof this.field2 !== 'undefined'){
            fields = fields + this.field2 + ',';

        }
        if(typeof this.field3 !== 'undefined'){
            fields = fields + this.field3 + ',';

        }
        if(typeof this.field4 !== 'undefined'){
            fields = fields + this.field4 + ',';

        }
        
        return fields;

    }
    // method to get columns and All records
    @wire(fetchData, { listValues: '$vals' , columnsValues: '$columnsVals'})
    wiredsobjects(result) {

        if (typeof result.data !== 'undefined') {
            if(result.data.columns){
                this.columnsfetch = result.data.columns;
            }
            if(result.data.sobj){
                this.recorddata = result.data.sobj;
            }
            
        }
        
    };


}
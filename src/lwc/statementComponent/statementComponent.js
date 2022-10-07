import { LightningElement,track, api} from 'lwc';
import {loadScript} from "lightning/platformResourceLoader";
import JSPDF from '@salesforce/resourceUrl/jspdf';
import getRecordsTransactionEntries from '@salesforce/apex/StatementComponentControler.getTransactionEntries';

export default class StatementComponent extends LightningElement {
    renderedCallback() {
		Promise.all([
			loadScript(this, JSPDF)
		]);
	}
    header=[{id:"Id",name:"ID",prompt: "ID",width: 65,align: "center", padding: 0},
            {id:"Name",name:"Name",prompt: "Name",width: 65,align: "center", padding: 0},
            {id:"Account__c",name:"Account",prompt: "Account",width: 65,align: "center", padding: 0},
            {id:"Status__c",name:"Status",prompt: "Status",width: 65,align: "center", padding: 0},
            {id:"Type__c",name:"Type",prompt: "Type",width: 65,align: "center", padding: 0}
        ];

    @api recId;
    @track transactionEntries;
    @track error;
    @track startD;
    @track endD;
    radioButtonValue;
    visibleEntries;
    file;
    data;
    columns = [
        {label: 'ID', fieldName: 'Id', type: 'Text'},
        {label: 'Name', fieldName: 'Name', type: 'Text'},
        {label: 'Amount', fieldName: 'Amount__c', type: 'Decimal'},
        {label: 'Status', fieldName: 'Status__c', type: 'Text'},
        {label: 'Type', fieldName: 'Type__c', type: 'Text'},
    ];
    handleStartDate(event){
        this.startD = event.target.value;
    }
    handleEndDate(event){
        this.endD = event.target.value;
    }
    handleclick(){
        console.log('show transactions button clicked')
        getRecordsTransactionEntries({ startD : this.startD , endD : this.endD, recId : this.recId})
        .then((result) =>{
        this.transactionEntries = result;
    })
    .catch((error) =>{
        this.error = error;
    });
    console.log('this is showing transaction entries')
    console.log(transactionEntries)
    }
    updatecall(event){
        this.visibleEntries=[...event.detail.allrecords]
        console.log(event.detail.allrecords)
    }

    value = '';

    get options() {
        return [
            { label: 'CSV', value: 'CSV' },
            
        ];
    }
    handleRadioButton(event){
        this.radioButtonValue = event.detail.value;
    }

    downloadCSV(){
       
        this.data = this.transactionEntries;
        console.log('data');
        console.log(this.data);
        this.data.forEach(function (record) {
            console.log(record);
        });
        let rowEnd = '\n';
        let csvString = '';
        // this set elminates the duplicates if have any duplicate keys
        let rowData = new Set();

        // getting keys from data
        this.data.forEach(function (record) {
            Object.keys(record).forEach(function (key) {
                rowData.add(key);
            });
        });

        // Array.from() method returns an Array object from any object with a length property or an iterable object.
        rowData = Array.from(rowData);
        
        // splitting using ','
        csvString += rowData.join(',');
        csvString += rowEnd;

        // main for loop to get the data based on key value
        for(let i=0; i < this.data.length; i++){
            let colValue = 0;

            // validating keys in data
            for(let key in rowData) {
                if(rowData.hasOwnProperty(key)) {
                    // Key value 
                    // Ex: Id, Name
                    let rowKey = rowData[key];
                    // add , after every value except the first.
                    if(colValue > 0){
                        csvString += ',';
                    }
                    // If the column is undefined, it as blank in the CSV file.
                    let value = this.data[i][rowKey] === undefined ? '' : this.data[i][rowKey];
                    csvString += '"'+ value +'"';
                    colValue++;
                }
            }
            csvString += rowEnd;
        }

        // Creating anchor element to download
        let downloadElement = document.createElement('a');

        // This  encodeURI encodes special characters, except: , / ? : @ & = + $ # (Use encodeURIComponent() to encode these characters).
        downloadElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csvString);
        downloadElement.target = '_self';
        // CSV File Name
        downloadElement.download = 'transactionEntries Data.csv';
        // below statement is required if you are using firefox browser
        document.body.appendChild(downloadElement);
        // click() Javascript function to download CSV file
        downloadElement.click(); 
    }


    downloadPDF(){
        console.log('we are in downloadPDF');
        const { jsPDF } = window.jspdf;
		const doc = new jsPDF();
		doc.table(30, 30, this.transactionEntries, this.headers, { autosize:true });
		doc.save("transactionEntries.pdf");
    }
    

    handleDownload(event){
        if(this.radioButtonValue === 'CSV'){
            this.file = 'CSV file will be Downloaded';
            this.downloadCSV();
        }
        if(this.radioButtonValue === 'PDF'){
            this.file = 'PDF file will be Downloaded';
            this.downloadPDF();
        }
        if(this.radioButtonValue === 'EmailPDF'){
            this.file = 'EmailPDF file will be Downloaded';
        }
    }
    
}
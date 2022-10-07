import { LightningElement, track, wire } from 'lwc';
import getTextMethod1 from '@salesforce/apex/GetTextMethod.getTextMethod1';
import getTextMethod2 from '@salesforce/apex/GetTextMethod.getTextMethod2';
import getTextMethod3 from '@salesforce/apex/GetTextMethod.getTextMethod3';

export default class GetApexMethod extends LightningElement {

    
    
    @track method1;
    @track error1;

    @track method2;
    @track error2;
    
    @track method3;
    @track error3;

    connectedCallback() {
        this.invokeApexMethods();
    }
    

//     @wire(getTextMethod1) output;
//     @wire(getTextMethod2) output1;
//     @wire(getTextMethod3) output2;
    

//     @wire(getTextMethod1)
//     wiredMethod({ error, data }) {
//         if (data) {
//             this.method1 = data;
//             this.error1 = undefined;
//         } else if (error) {
//             this.error1 = error;
//             this.method1 = undefined;
//         }
//     }

//    @wire(getTextMethod2)
//     wiredMethod1({ error, data }) {
//         if (data) {
//             this.method2 = data;
//             this.error2 = undefined;
//         } else if (error) {
//             this.error2 = error;
//             this.method2 = undefined;
//         }
//     }

//     @wire(getTextMethod3)
//     wiredMethod2({ error, data }) {
//         if (data) {
//             this.method3 = data;
//             this.error3 = undefined;
//         } else if (error) {
//             this.error3 = error;
//             this.method3 = undefined;
//         }
//     }

    invokeApexMethods(){
        getTextMethod1()
        .then((result) =>{
            this.method1 = result;
            console.log(this.method1);
            getTextMethod2({
                //message1: result
            })
            .then((result1) => {
                this.method2 = result1;
                console.log(this.method2);
                getTextMethod3({
                    message2: result1
                })
                .then((result2) =>{
                    this.method3=result2;
                })
                .catch((error) =>{
                    this.error3=error;
                })
            })
            
            .catch((error) => {
                this.error2= error;
            })
        })
        .catch((erroe) => {
            this.error1 = error;
        });
    }    
    
}
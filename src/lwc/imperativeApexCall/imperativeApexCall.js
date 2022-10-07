import { LightningElement } from 'lwc';
import getTextMethod1 from '@salesforce/apex/GetTextMethod.getTextMethod1';
import getTextMethod2 from '@salesforce/apex/GetTextMethod.getTextMethod2';
import getTextMethod3 from '@salesforce/apex/GetTextMethod.getTextMethod3';


export default class ImperativeApexCall extends LightningElement {

    method1;
    error1;
    output;

    handler1(){
        getTextMethod1()
        .then((result) => {this.mathod1=result;
                            this.error1=undefined;
                        })
        .catch((error) =>{this.error1=error;
                            this.method1=undefined;
                        });
                        console.log('this call in undefined');
        console.log(this.method1.data);
    }
}
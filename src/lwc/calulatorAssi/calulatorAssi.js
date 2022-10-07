import { LightningElement } from 'lwc';

export default class CalulatorAssi extends LightningElement {
    currOutput;
    fstNumber
    sndNumber
    oprationVariable
    firstHandler(event){
        
        this.fstNumber=event.target.value;
    }
    seconHandler(event){
        this.sndNumber=event.target.value;
    }
    addHandler(event){
        this.oprationVariable=(parseFloat(this.fstNumber)+parseFloat(this.sndNumber));
    
        if(Object.is(this.oprationVariable,NaN)){
            this.currOutput='Please Enter the Valid Input';
        }
        else{
            this.currOutput='Addition of both number is: '+parseFloat(parseFloat(this.fstNumber)+parseFloat(this.sndNumber));
        }
        
        this.template.querySelectorAll('lightning-input[data-id="reset"]').forEach(element => {
            element.value = null;
          });
    }
    subHandler(event){
        this.oprationVariable=(parseFloat(this.fstNumber)-parseFloat(this.sndNumber));
        if(Object.is(this.oprationVariable,NaN)){
            this.currOutput='Please Enter the Valid Input';
        }
        else{
            this.currOutput='Subtraction of both number is: '+parseFloat(parseFloat(this.fstNumber)-parseFloat(this.sndNumber));
        }
        this.template.querySelectorAll('lightning-input[data-id="reset"]').forEach(element => {
            element.value = null;
          });
    }
    mulHandler(event){
        this.oprationVariable=(parseFloat(this.fstNumber)*parseFloat(this.sndNumber));
        if(Object.is(this.oprationVariable,NaN)){
            this.currOutput='Please Enter the Valid Input';
        }
        else{
            this.currOutput='Multiplication of both number is: '+(parseFloat(this.fstNumber)*parseFloat(this.sndNumber));

        }
        this.template.querySelectorAll('lightning-input[data-id="reset"]').forEach(element => {
            element.value = null;
          });
    }
    divHandler(event){
        this.oprationVariable=(parseFloat(this.fstNumber)/parseFloat(this.sndNumber));
        if(Object.is(this.oprationVariable,NaN)){
            this.currOutput='Please Enter the Valid Input';
        }
        else if(this.sndNumber === 0){
            this.currOutput='Division of both number is Undifined';
        }
        else if(this.fstNumber === 0||-0 && this.sndNumber === 0||-0){
            this.currOutput='Division of both number is Undifined';
        }
        else{
            this.currOutput='Division of both number is: '+(parseFloat(this.fstNumber)/parseFloat(this.sndNumber));
        }
        this.template.querySelectorAll('lightning-input[data-id="reset"]').forEach(element => {
            element.value = null;
          });
        
    }
    
}
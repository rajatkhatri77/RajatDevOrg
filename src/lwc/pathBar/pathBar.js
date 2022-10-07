import { LightningElement, track } from 'lwc';

export default class PathBar extends LightningElement {
    @track stepSelector = 'Step 1';
    clickValue;

    handleNext() {
        var getselectedStep = this.stepSelector;
        if(getselectedStep === 'Step 1'){
            this.stepSelector = 'Step 2';
        }
        else if(getselectedStep === 'Step 2'){
            this.stepSelector = 'Step 3';
        }
        else if(getselectedStep === 'Step 3'){
            this.stepSelector = 'Step 4';
        }
    }
 
    handlePrev() {
        var getselectedStep = this.stepSelector;
        if(getselectedStep === 'Step 2'){
            this.stepSelector = 'Step 1';
        }
        else if(getselectedStep === 'Step 3'){
            this.stepSelector = 'Step 2';
        }
        else if(getselectedStep === 'Step 4'){
            this.stepSelector = 'Step 3';
        }
    }

    handleStepBlur(event) {
        //console.log('ABC'+ event.target.value);
        //console.log('ABC'+ event.target.dataset.val);
        //const stepIndex = event.detail.index;
        this.clickValue=event.target.value;
        console.log('This is in onclick: ' + this.clickValue);
    }
    markThisAsStage(event){
        this.stepSelector=this.clickValue;
    }
    get isSelectStep4() {
        return this.stepSelector === "Step 4";
    }
    handleFinish(){
        this.stepSelector = 'Finished';
        alert('Finished..');
        this.stepSelector = 'Step 1';
    }
}
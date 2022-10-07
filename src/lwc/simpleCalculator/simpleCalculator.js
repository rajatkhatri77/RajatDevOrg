import { LightningElement, track } from 'lwc';

export default class SimpleCalculator extends LightningElement {
    @track currentResult
    firstNumber
    secondNumber
    @track previousResults = [];


    handleNumberChange(event){
        const inputBoxName = event.target.name;
        console.log(inputBoxName)
        if(inputBoxName === 'firstNumber'){
            this.firstNumber = event.target.value;
            console.log(this.firstNumber);
        } else if(inputBoxName === 'secondNumber'){
            this.secondNumber = event.target.value;
            console.log(this.firstNumber);
        }
    }

    handleAdd(){
        const fNum = parseInt(this.firstNumber);
        const sNum = parseInt(this.secondNumber);
        console.log('handleAdd')
        this.currentResult = `Result of ${this.firstNumber} + ${this.secondNumber} is ${fNum + sNum}`;
        console.log( this.currentResult);
        this.previousResults.push(this.currentResult);
    }

    handlesubtract(){
        const fNum = parseInt(this.firstNumber);
        const sNum = parseInt(this.secondNumber);
        console.log('handlesubtract')
        this.currentResult = `Result of ${this.firstNumber} + ${this.secondNumber} is ${fNum - sNum}`;
        console.log( this.currentResult);
        this.previousResults.push(this.currentResult);
    }

    handleMultiply(){
        const fNum = parseInt(this.firstNumber);
        const sNum = parseInt(this.secondNumber);
        console.log('handleMultiply')
        this.currentResult = `Result of ${this.firstNumber} + ${this.secondNumber} is ${fNum * sNum}`;
        console.log( this.currentResult);
        this.previousResults.push(this.currentResult);
    }
    handleDivision(){
        const fNum = parseInt(this.firstNumber);
        const sNum = parseInt(this.secondNumber);
        console.log('handleDivision')
        this.currentResult = `Result of ${this.firstNumber} + ${this.secondNumber} is ${fNum / sNum}`;
        console.log( this.currentResult);
        this.previousResults.push(this.currentResult);
    }

}
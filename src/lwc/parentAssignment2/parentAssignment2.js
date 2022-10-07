import { LightningElement,api } from 'lwc';

export default class ParentAssignment2 extends LightningElement {

    handleClick(){
        this.template.querySelector('c-child-assignment2').handlerload();
    }
}
import { LightningElement } from 'lwc';

export default class ParentListOfContact extends LightningElement {

    strContact='';

    
    handelChange(event){
        this.strContact=event.target.value;
        console.log(this.strContact);
    }
    
    callChildFunction(event){
        const objchild = this.template.querySelector('c-child-list-of-contact');
        objchild.contactToList(this.strContact);

    }

   

}
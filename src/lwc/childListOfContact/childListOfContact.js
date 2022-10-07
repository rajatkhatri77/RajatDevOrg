import { LightningElement,track,api} from 'lwc';

export default class ChildListOfContact extends LightningElement {
    @track listContact=["Rajat", "Sudhanshu", "Itishmita", "Dilip"];

    @api
    contactToList(strContact){
        this.listContact.push(strContact);
    }
}
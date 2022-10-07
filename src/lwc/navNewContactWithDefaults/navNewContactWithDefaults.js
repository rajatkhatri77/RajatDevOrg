import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { encodeDefaultFieldValues } from 'lightning/pageReferenceUtils';

export default class NavNewContactWithDefaults extends NavigationMixin(LightningElement) {
    

    navtonewcontactwithdefault(){
        const defaultvalues = encodeDefaultFieldValues({
            FirstName: 'Test',
            LastName: 'Contact'
        });



        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes:{
                objectApiName: 'Contact',
                actionName: 'new'
            },
            state:{
                defaultFieldValues: defaultvalues
            }
        });
    }
}
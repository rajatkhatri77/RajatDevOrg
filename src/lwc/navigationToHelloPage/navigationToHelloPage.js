import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class NavigationToHelloPage extends LightningElement {

    navtohellopage(){
        this[NavigationMixin.Navigate]({
            type: 'standard__navItemPage',
            attribute: {
                apiName: 'Hello'
            }
        });
    }
}
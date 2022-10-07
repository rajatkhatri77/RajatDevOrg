import { LightningElement } from 'lwc';
import { NavigatorMixin } from 'lightning/navigation';
export default class NavToRecentListView extends NavigatorMixin(LightningElement) {
    navtorecentlistview(){
        this[NavigatorMixin.Navigate]({
            type: 'standard__objectPage',
            attribute: {
                objectApiName: 'Contact',
                actionName: 'list'
            },
            state: {
                filterName: 'Recent'
            }
        });
    }
}
import { LightningElement,api } from 'lwc';

export default class ChildEventWithData extends LightningElement {

    @api contact;

    handleClick(event) {
        event.preventDefault();
        const selectEvent = new CustomEvent('selectid', {
            detail: this.contact.Id
        });
        this.dispatchEvent(selectEvent);
    }
}
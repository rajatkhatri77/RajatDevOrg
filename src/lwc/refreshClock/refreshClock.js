import { LightningElement, api} from 'lwc';

export default class RefreshClock extends LightningElement {

    handelclick(){
        this.template.querySelector('c-clock').refresh();
    }
}
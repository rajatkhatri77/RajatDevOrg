import { LightningElement, api } from 'lwc';

export default class ParenttileViewWithFlexiregionInfo extends LightningElement {

    sizeOfComponent;
    error;
    @api flexipageRegionWidth=12;
    sizeOfComponent=flexipageRegionWidth;
    
    
}
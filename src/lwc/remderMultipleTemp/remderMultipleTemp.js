import { LightningElement } from 'lwc';
import page1 from './page1.html';
import page2 from './page2.html';
//import defaultTemp from './remderMultipleTemp';

export default class RemderMultipleTemp extends LightningElement {

    selected=true;

    

    render(){
        return this.selected  ? page1:page2;
    }

    handleclick(event){
        this.selected=!this.selected;
        console.log(this.selected);
    }
}
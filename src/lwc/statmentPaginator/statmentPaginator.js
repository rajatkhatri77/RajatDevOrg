import { LightningElement, api } from 'lwc';

export default class StatmentPaginator extends LightningElement {
    totalrecords
    recordsize=4
    get records(){
        return this.visibleRecord
    }
    @api
    set records(data){
        if(data){
            this.totalrecords=data
            this.visibleRecord = data.slice(0,this.recordsize)
            this.totalPage = Math.ceil(data.length/this.recordsize)
        }
    }
    handlePrevious(){

    }
    handleNext(){

    }

    updateRecord(){
        this.dispatchEvent(new CustomEvent('update',{
            details:{
                records:this.visibleRecord
            }
        }))
    }
}
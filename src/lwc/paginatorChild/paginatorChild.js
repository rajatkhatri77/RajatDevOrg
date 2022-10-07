import { api, LightningElement } from 'lwc';

export default class PaginatorChild extends LightningElement {
    currentpage=1;
    totalRecords;
    recordSize=10;
    totalpage=0;

    get allrecords(){
        return this.visibleRecords
    }
    
    @api
    set allrecords(data){
        if(data){
            this.totalRecords=data
            this.totalpage=Math.ceil(data.length/this.recordSize)
            this.updateRecords()
        }

    }

    handlePrevious(){
        if(this.currentpage !== 1){
            this.currentpage=this.currentpage-1
            this.updateRecords()
        }

    }

    handleNext(){
        if(this.currentpage < this.totalpage){
            this.currentpage=this.currentpage+1
            this.updateRecords()
        }
    }

    updateRecords(){
        const str=(this.currentpage-1)*this.recordSize
        const endd=(this.recordSize)*this.currentpage
        this.visibleRecords=this.totalRecords.slice(str,endd)
        this.dispatchEvent(new CustomEvent('update',{
            detail: {allrecords: this.visibleRecords}
        }))
    }
}
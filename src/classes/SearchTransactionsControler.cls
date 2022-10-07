/**
*  Description     :  This is the Apex class for Backend functioning of VF page Search Transactions
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  04/22/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
public with sharing class SearchTransactionsControler {
    public String renderForBlock{get;set;}

    //flags for pageblocks 
    public boolean amountFlag{get;set;}
    public boolean dateFlag{get;set;}
    public boolean typeFlag{get;set;}
    public boolean statusFlag{get;set;}
    public boolean accNoFlag{get;set;}
    //flag for pageblocktable
    public boolean amountTableFlag{get;set;}
    public boolean dateTableFlag{get;set;}
    public boolean typeTableFlag{get;set;}
    public boolean statusTableFlag{get;set;}
    public boolean accNoTableFlag{get;set;}
  
    public decimal startAmount{get;set;}
    public decimal endAmount{get;set;}
    public List<SearchTransactionsControlerWrapper> tranEntriesInAmountRange {get;set;}
    public Date startD{get;set;}
    public Date endD{get;set;}
    public List<SearchTransactionsControlerWrapper> tranEntriesInBetweenDates {get;set;}
    public String type {get;set;}
    public List<SearchTransactionsControlerWrapper> tranEntriesOfType {get;set;}
    public String status {get;set;}
    public List<SearchTransactionsControlerWrapper> tranEntriesOfStatus {get;set;}
    public String accNo {get;set;}
    public List<SearchTransactionsControlerWrapper> tranEntriesOfAccNo {get;set;}

    //constructor
    public SearchTransactionsControler(){
        amountFlag = true;
        dateFlag = false;
        typeFlag = false;
        statusFlag = false;
        accNoFlag = false;
        amountTableFlag = false;
        dateTableFlag = false;
        typeTableFlag = false;
        statusTableFlag = false;
        accNoTableFlag = false;
        tranEntriesInAmountRange = new List<SearchTransactionsControlerWrapper>();
        tranEntriesInBetweenDates = new List<SearchTransactionsControlerWrapper>();
        tranEntriesOfType = new List<SearchTransactionsControlerWrapper>();
        tranEntriesOfStatus = new List<SearchTransactionsControlerWrapper>();
        tranEntriesOfAccNo = new List<SearchTransactionsControlerWrapper>();

    }
    //picklist to select on which parameter you want to Search Transaction entries
    Public List<Selectoption> getselecteBlock(){
        List<Selectoption> listBlock = new List<selectoption>();
        listBlock.add(new selectOption('Amount between', 'Amount between'));
        listBlock.add(new selectOption('Date Between', 'Date Between'));
        listBlock.add(new selectOption('Entry Name', 'Entry Name'));
        listBlock.add(new selectOption('Status', 'Status'));
        listBlock.add(new selectOption('Account Number', 'Account Number'));
        
        return listBlock; 
    }
    //for which pageBlock to Display
    public void renderAction(){
        if(renderForBlock == 'Amount between'){
            amountFlag = true;
            dateFlag = false;
            typeFlag = false;
            statusFlag = false;
            accNoFlag = false;
        }
        if(renderForBlock == 'Date Between'){
            amountFlag = false;
            dateFlag = true;
            typeFlag = false;
            statusFlag = false;
            accNoFlag = false;
        }
        if(renderForBlock == 'Entry Name'){
            amountFlag = false;
            dateFlag = false;
            typeFlag = true;
            statusFlag = false;
            accNoFlag = false;
        }
        if(renderForBlock == 'Status'){
            amountFlag = false;
            dateFlag = false;
            typeFlag = false;
            statusFlag = true;
            accNoFlag = false;
        }
        if(renderForBlock == 'Account Number'){
            amountFlag = false;
            dateFlag = false;
            typeFlag = false;
            statusFlag = false;
            accNoFlag = true;
        }
    }

    /**
    * 
    *   @description    :   In this method we are fetching the transaction entries on the basis of amount
    *
    *   @args           :   Two decimal values
    *
    *   @return         :   List<Transaction_Entry__c>
    *
    *   @revision Log   :   V1.1 - Created  - 04/22/2021 - Rajat khatri
    * 
    **/
    public pagereference tranEntriesWithAmount(){
        tranEntriesInAmountRange = new List<SearchTransactionsControlerWrapper>();
        if(startAmount > endAmount){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Start Amount is greater than the end Amount'));
            return null;
        }
        List<Transaction_Entry__c> tranEntriesForAmount = [SELECT Id,Name,Amount__c,Status__c,Type__c,Contact__r.Account_Number__c,Contact__r.Name,Transaction_Date__c FROM Transaction_Entry__c WHERE Amount__c >=:startAmount AND Amount__c <=:endAmount];
        if(tranEntriesForAmount.size() > 0){
            amountTableFlag = true;
            dateTableFlag = false;
            typeTableFlag = false;
            statusTableFlag = false;
            accNoTableFlag = false;
            for(Transaction_Entry__c tEntry : tranEntriesForAmount){
                SearchTransactionsControlerWrapper wrapperObj = new SearchTransactionsControlerWrapper();
                wrapperObj.tranId = tEntry.Id;
                wrapperObj.contactName = tEntry.Contact__r.Name;
                wrapperObj.tranAccontNo = tEntry.Contact__r.Account_Number__c;
                wrapperObj.name = tEntry.Name;
                wrapperObj.amount = tEntry.Amount__c;
                wrapperObj.type = tEntry.Type__c;
                wrapperObj.status = tEntry.Status__c;
                wrapperObj.tranDate = tEntry.Transaction_Date__c;
                tranEntriesInAmountRange.add(wrapperObj);
            }
        }
        return null;
    }

    /**
    * 
    *   @description    :   In this method we are fetching the transaction entries on the basis of Dates.
    *
    *   @args           :   Two date values
    *
    *   @return         :   List<Transaction_Entry__c>
    *
    *   @revision Log   :   V1.1 - Created  - 04/22/2021 - Rajat khatri
    * 
    **/
    public pagereference tranEntriesWithDate(){
        tranEntriesInBetweenDates = new List<SearchTransactionsControlerWrapper>();
        if(startD > endD){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Start Date is greater than the end Dete'));
            return null;
        }
        List<Transaction_Entry__c> tranEntriesForDates = [SELECT Id,Name,Amount__c,Status__c,Type__c,Contact__r.Account_Number__c,Contact__r.Name,Transaction_Date__c FROM Transaction_Entry__c WHERE Transaction_Date__c >=:startD AND Transaction_Date__c <=:endD];
        if(tranEntriesForDates.size() > 0){
            amountTableFlag = false;
            dateTableFlag = true;
            typeTableFlag = false;
            statusTableFlag = false;
            accNoTableFlag = false;
            for(Transaction_Entry__c tEntry : tranEntriesForDates){
                SearchTransactionsControlerWrapper wrapperObj = new SearchTransactionsControlerWrapper();
                wrapperObj.tranId = tEntry.Id;
                wrapperObj.contactName = tEntry.Contact__r.Name;
                wrapperObj.tranAccontNo = tEntry.Contact__r.Account_Number__c;
                wrapperObj.name = tEntry.Name;
                wrapperObj.amount = tEntry.Amount__c;
                wrapperObj.type = tEntry.Type__c;
                wrapperObj.status = tEntry.Status__c;
                wrapperObj.tranDate = tEntry.Transaction_Date__c;
                tranEntriesInBetweenDates.add(wrapperObj);
            }
        }
        return null;
    }
    //to display Transaction Type Picklist
    Public List<Selectoption> getselectedType(){
        List<Selectoption> listType = new List<selectoption>();
        listType.add(new selectOption('', '- None -'));
        listType.add(new selectOption('Credit', 'Credit'));
        listType.add(new selectOption('Debit', 'Debit'));
        
        return listType; 
    }

    /**
    * 
    *   @description    :   In this method we are fetching the transaction entries on the basis of Transaction Type.
    *
    *   @args           :   String
    *
    *   @return         :   List<Transaction_Entry__c>
    *
    *   @revision Log   :   V1.1 - Created  - 04/22/2021 - Rajat khatri
    * 
    **/
    public pagereference transactionEntriesOfTpye(){
        tranEntriesOfType = new List<SearchTransactionsControlerWrapper>();
        if(type == '' || type == null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Select the type of transaction'));
            return null;
        }
        List<Transaction_Entry__c> tranEntriesForType = [SELECT Id,Name,Amount__c,Status__c,Type__c,Contact__r.Account_Number__c,Contact__r.Name,Transaction_Date__c FROM Transaction_Entry__c WHERE Type__c =:type];
        if(tranEntriesForType.size() > 0){
            amountTableFlag = false;
            dateTableFlag = false;
            typeTableFlag = true;
            statusTableFlag = false;
            accNoTableFlag = false;
            for(Transaction_Entry__c tEntry : tranEntriesForType){
                SearchTransactionsControlerWrapper wrapperObj = new SearchTransactionsControlerWrapper();
                wrapperObj.tranId = tEntry.Id;
                wrapperObj.contactName = tEntry.Contact__r.Name;
                wrapperObj.tranAccontNo = tEntry.Contact__r.Account_Number__c;
                wrapperObj.name = tEntry.Name;
                wrapperObj.amount = tEntry.Amount__c;
                wrapperObj.type = tEntry.Type__c;
                wrapperObj.status = tEntry.Status__c;
                wrapperObj.tranDate = tEntry.Transaction_Date__c;
                tranEntriesOfType.add(wrapperObj);
            }
        }
        return null;
    }

    //to display transaction status plicklist
    Public List<Selectoption> getselectedStatus(){
        List<Selectoption> listStatus = new List<selectoption>();
        listStatus.add(new selectOption('', '- None -'));
        listStatus.add(new selectOption('Completed', 'Completed'));
        listStatus.add(new selectOption('Pending', 'Pending'));
        listStatus.add(new selectOption('Cancelled.', 'Cancelled.'));
        
        return listStatus; 
    }

    /**
    * 
    *   @description    :   In this method we are fetching all the transaction entries on the basis of the transaction status
    *
    *   @args           :   String
    *
    *   @return         :   List<Transaction_Entry__c>
    *
    *   @revision Log   :   V1.1 - Created  - 04/22/2021 - Rajat khatri
    * 
    **/
    public pagereference transactionEntriesOfStatus(){
        tranEntriesOfStatus = new List<SearchTransactionsControlerWrapper>();
        if(status == '' || status == null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Select the status of transaction'));
            return null;
        }
        List<Transaction_Entry__c> tranEntriesForStatus = [SELECT Id,Name,Amount__c,Status__c,Type__c,Contact__r.Account_Number__c,Contact__r.Name,Transaction_Date__c FROM Transaction_Entry__c WHERE Status__c =:status];
        if(tranEntriesForStatus.size() > 0){
            amountTableFlag = false;
            dateTableFlag = false;
            typeTableFlag = false;
            statusTableFlag = true;
            accNoTableFlag = false;
            for(Transaction_Entry__c tEntry : tranEntriesForStatus){
                SearchTransactionsControlerWrapper wrapperObj = new SearchTransactionsControlerWrapper();
                wrapperObj.tranId = tEntry.Id;
                wrapperObj.contactName = tEntry.Contact__r.Name;
                wrapperObj.tranAccontNo = tEntry.Contact__r.Account_Number__c;
                wrapperObj.name = tEntry.Name;
                wrapperObj.amount = tEntry.Amount__c;
                wrapperObj.type = tEntry.Type__c;
                wrapperObj.status = tEntry.Status__c;
                wrapperObj.tranDate = tEntry.Transaction_Date__c;
                tranEntriesOfStatus.add(wrapperObj);
            }
        }
        return null;
    }

    /**
    * 
    *   @description    :   In this method we are fetching all the transaction entries on the basis of Account number of Contact.
    *
    *   @args           :   String
    *
    *   @return         :   List<Transaction_Entry__c>
    *
    *   @revision Log   :   V1.1 - Created  - 04/22/2021 - Rajat khatri
    * 
    **/
    public pagereference transactionEntriesOfAccNo(){
        tranEntriesOfAccNo = new List<SearchTransactionsControlerWrapper>();
        List<Contact> con = [SELECT Id,Account_Number__c FROM Contact WHERE Account_Number__c=:accNo];
        if(con.size() > 0){
            String conId = string.valueOf(con[0].Id);
            List<Transaction_Entry__c> tranEntriesForAccNo = [SELECT Id,Name,Amount__c,Status__c,Type__c,Contact__r.Account_Number__c,Contact__r.Name,Transaction_Date__c FROM Transaction_Entry__c WHERE Contact__c =:conId];
            if(tranEntriesForAccNo.size() > 0){
                amountTableFlag = false;
                dateTableFlag = false;
                typeTableFlag = false;
                statusTableFlag = false;
                accNoTableFlag = true;
                for(Transaction_Entry__c tEntry : tranEntriesForAccNo){
                    SearchTransactionsControlerWrapper wrapperObj = new SearchTransactionsControlerWrapper();
                    wrapperObj.tranId = tEntry.Id;
                    wrapperObj.contactName = tEntry.Contact__r.Name;
                    wrapperObj.tranAccontNo = tEntry.Contact__r.Account_Number__c;
                    wrapperObj.name = tEntry.Name;
                    wrapperObj.amount = tEntry.Amount__c;
                    wrapperObj.type = tEntry.Type__c;
                    wrapperObj.status = tEntry.Status__c;
                    wrapperObj.tranDate = tEntry.Transaction_Date__c;
                    tranEntriesOfAccNo.add(wrapperObj);
                }
            }
        }
        return null;
    }


    //wrapper class
    private class SearchTransactionsControlerWrapper{

        public Id tranId {get;set;}
        public String contactName {get;set;}
        public String tranAccontNo {get;set;}
        public String name {get;set;}
        public Decimal amount {get;set;}
        public String type {get;set;}
        public String status {get;set;}
        public Date tranDate {get;set;}
    }
}
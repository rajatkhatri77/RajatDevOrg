/**
*  Description     :  This is Batch and schedule class
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  02/12/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
global class Batch_BatchAndSchedule implements Schedulable,Database.Batchable<SObject>{
    public Integer intt = 0;
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id,Batch_Count__c FROM Contact');
    }
    global void execute(Database.BatchableContext bc, List<Contact> scope){
        List<Contact> contacts = new List<Contact>();
        for(Contact con : scope){
            con.Batch_Count__c = intt + 1;
            //contacts.add(con);
        }
        //update contacts;
    }
    global void finish(Database.BatchableContext bc){
        
    }
    
    global void execute(SchedulableContext ctx){
        Database.executeBatch(new Batch_BatchAndSchedule());
        //Batch_BatchAndSchedule Batch = new Batch_BatchAndSchedule();
        
    }

    
    
}
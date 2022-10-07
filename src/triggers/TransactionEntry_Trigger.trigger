/**
*  Purpose         :  This trigger is to handle all the pre and post processing operations for Transaction Entry objects.
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  04/14/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/

trigger TransactionEntry_Trigger on Transaction_Entry__c (before insert){
    if(Trigger.isBefore ){
        if(Trigger.isInsert){
            //this will check the Transaction limits for Transaction Entries
            //TransactionEntryTriggerHandler.checkTransactionLimit(Trigger.new);
            TransactionEntryTriggerHelper.validationOnTransactionEntries(Trigger.new);
        }
    }
}
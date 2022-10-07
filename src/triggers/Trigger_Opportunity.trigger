/**
*  Purpose         :  This trigger is to handle all the pre and post processing operations for Opportunity objects.
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  06/19/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
trigger Trigger_Opportunity on Opportunity (after insert,after update,before delete) {
    if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isupdate){
            //OpportunityTriggerHelper.updateContactLoaction(Trigger.new,Trigger.oldMap);  
            OpportunityTriggerHelper.automobileRecordMaintenance(Trigger.new,null);
        }
    }
    /*if(Trigger.isbefore){
        if(Trigger.isdelete){
            OpportunityTriggerHelper.updateContactLoaction1(Trigger.new);            
        }
    }*/

}
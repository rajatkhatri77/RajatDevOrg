/**
*  Purpose         :  This trigger is to handle all the pre and post processing operations for Account objects.
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  01/22/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
trigger Trigger_Account on Account (before insert, before update, after insert, after update){
    if(Trigger.isBefore ){
        if(Trigger.isInsert || Trigger.isUpdate){
        //This wil call the method in Adding field Account trigger handler class 
        AccountTriggerHandler.addingFieldAAndFieldB(Trigger.new);
        }
    }
    if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate){
        //This wil call the method ccreate contact on Account with lastname in trigger handler class
        AccountTriggerHandler.creatingContactOnAccountWithLastName(Trigger.new,Trigger.oldMap);
        //This will call the method to create and delete contac according the txt entred in Contact_Detaisls.
        AccountTriggerHandler.contactDetailsInsertAndDeleteOnAccount(Trigger.new,Trigger.oldMap);
        //
        AccountTriggerHandler.creatingContactAndOpportunityFromContOppFeild(Trigger.new,Trigger.oldMap);
        }
    }
}
/**
*  Purpose         :  This trigger is to handle all the pre and post processing operations for Contact objects.
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  02/09/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
trigger Trigger_Contact on Contact (before insert, before delete, after insert) {
    
    /*if(Trigger.isAfter){
        if(Trigger.isInsert){
            String jsonstr = json.serialize(Trigger.new);
            ContactTriggerHandler.qrCodeGenerator(jsonstr);
        }
    }*/
    
     /* if(Trigger.isBefore ){
        if(Trigger.isInsert){
            //this method will call contactDuplicateAndPotentialDuplicate from contacTrigger handler and perform following -> checking the duplicate if then throw error and Potential Duplicate then relate that contact all related contacts.
            ContactTriggerHandler.contactDuplicateAndPotentialDuplicateCheck(Trigger.new);
            //this method will call contactEmailDuplictecheck and will check the duplicte email if found duplicte it will throw error
            //ContactTriggerHandler.contactEmailDuplicateCheck(Trigger.new);
        }
    }*/
    

}
/**
*  Description     :  This is the Apex class for Backend functioning for LWC component for Mini Statment
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  04/19/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
public with sharing class MiniStatmentComponentControler {
    /**
    * 
    *   @description    :   In this method we are fetching transaction entries based on the passed record Id.
    *
    *   @args           :   String
    *
    *   @return         :   List<Transaction_Entry__c>
    *
    *   @revision Log   :   V1.1 - Created  - 04/19/2021 - Rajat khatri
    * 
    **/
    @AuraEnabled(cacheable=true)
    public static List<Transaction_Entry__c> getTransactionEntries(String recId, Integer selectedOption){
        if(String.isNotBlank(recId) || selectedOption != null){
            List<Transaction_Entry__c> trnEntries  = [SELECT Id,Name,Amount__C,Status__c,Type__c FROM Transaction_Entry__c WHERE
                                                      Contact__c=:recId LIMIT :selectedOption];
            System.debug(trnEntries);
            if(trnEntries.size() > 0){
                return trnEntries;
            }
        }
        return null; 
    }
}
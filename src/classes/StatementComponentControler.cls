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
public with sharing class StatementComponentControler {
    /**
    * 
    *   @description    :   In this method we are passing the record if from the lwc component while calling the Apex class and returning the list of transaction entries. 
    *
    *   @args           :   Date
    *
    *   @return         :   List<Transaction_Entry__c>
    *
    *   @revision Log   :   V1.1 - Created  - 04/19/2021 - Rajat khatri
    * 
    **/
    @AuraEnabled(cacheable=true)
    public static List<Transaction_Entry__c> getTransactionEntries(Date startD, Date endD, String recId){
        System.debug('Start date ' + startD);
        System.debug('end date ' + endD);
        System.debug('id: ' + recId);
        System.debug('SELECT Id,Amount__c,Status__c,Type__c,Name,Transaction_Date__c FROM Transaction_Entry__c WHERE Contact__c =:' + recId + ' AND Transaction_Date__c >=:' + startD + ' AND Transaction_Date__c <=:'+ endD);
        Integer numberDays = startD.daysBetween(endD);
        System.debug('days in between: ' + numberDays);
        if(recId != null || startD != null || endD != null || numberDays <= 180){
            List<Transaction_Entry__c> trnEntries = [SELECT Id,Amount__c,Status__c,Type__c,Name,Transaction_Date__c FROM Transaction_Entry__c WHERE Contact__c =: recId AND Transaction_Date__c >=:startD AND Transaction_Date__c <=:endD];
            if(trnEntries.size() > 0){
                System.debug(trnEntries);
                return trnEntries;
            }
        }
        return null;
        

    }
}
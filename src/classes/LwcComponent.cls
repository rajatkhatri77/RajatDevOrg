/**
*  Description     :  This is the Apex class for Backend functioning for LWC component.
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  03/18/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
public with sharing class LwcComponent {
    //this annotate is use for calling the Apex class from LWC component
    
    /**
    * 
    *   @description    :   In this method we are taking String as argument name of Sobject and then fetching the records from the that Sobject.
    *
    *   @args           :   Sobject
    *
    *   @return         :   List<Sobject>
    *
    *   @revision Log   :   V1.1 - Created  - 03/18/2021 - Rajat khatri
    * 
    **/
    @AuraEnabled(cacheable=true)
    public static List<SObject> getRecordsOfSobjects(String sobjName){
        //making the string for DynamicSoql
        String srtForSOQL = 'SELECT Id, Name, Phone FROM ' + String.escapeSingleQuotes(sobjName) + ' WITH SECURITY_ENFORCED';
        //appling the Dynamic SOQL
        List<SObject> objList = Database.query(srtForSOQL);
        //returning the list of records
        return objList;
    }
    
    /**
    * 
    *   @description    :   In this method we are taking two String as argument name of  and Stage of opportunities and then fetching the records from the that Sobject.
    *
    *   @args           :   Sobject
    *
    *   @return         :   List<Sobject>
    *
    *   @revision Log   :   V1.1 - Created  - 03/18/2021 - Rajat khatri
    * 
    **/
    @AuraEnabled(cacheable=true)
    public static List<SObject> getRecordsOfOpportunities(String sobjName, String stage){
        String srtForSOQL;
        //making the string for DynamicSoql
        if(stage == '--None--'){
            srtForSOQL = 'SELECT Id, Name, StageName, LeadSource FROM ' + String.escapeSingleQuotes(sobjName);/* + ' WITH SECURITY_ENFORCED';*/
            System.debug('if case->'+srtForSOQL);
        }
        else{
            srtForSOQL = 'SELECT Id, Name, StageName, LeadSource FROM ' + String.escapeSingleQuotes(sobjName) + ' WHERE StageName = '+ '\''+String.escapeSingleQuotes(stage)+'\'';
            System.debug('else case->'+srtForSOQL);
        }

        //srtForSOQL = 'SELECT Id, Name, StageName, LeadSource FROM Opportunity';
        //appling the Dynamic SOQL
        List<SObject> objList = Database.query(srtForSOQL);
        //returning the list of records
        return objList;
    
}

    /**
    * 
    *   @description    :   In this method we not takin any argument returning the list of Accounts that and i will call this function from the lwc ldataServiceDeleteRecord
    *
    *   @args           :   
    *
    *   @return         :   List<Account>
    *
    *   @revision Log   :   V1.1 - Created  - 03/24/2021 - Rajat khatri
    * 
    **/
    @AuraEnabled(cacheable=true)
    public static List<Account> getAllRecordsOfAccounts(){
        return [SELECT Id, Name FROM Account WITH SECURITY_ENFORCED LIMIT 10];
    }

    /**
    * 
    *   @description    :   In this method we not takin any argument returning the list of Contacts
    *
    *   @args           :   
    *
    *   @return         :   List<Contact>
    *
    *   @revision Log   :   V1.1 - Created  - 03/25/2021 - Rajat khatri
    * 
    **/
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactRecords(){
        return [SELECT Id, Name, Title, Phone, Email FROM Contact WITH SECURITY_ENFORCED];
    }


    /**
    * 
    *   @description    :   In this method we not takin any argument returning the list of Contacts
    *
    *   @args           :   
    *
    *   @return         :   List<Contact>
    *
    *   @revision Log   :   V1.1 - Created  - 03/26/2021 - Rajat khatri
    * 
    **/
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactAllRecords(){
        return [SELECT Id, Name, Title, Phone, Email FROM Contact WITH SECURITY_ENFORCED LIMIT 10];
    }

}
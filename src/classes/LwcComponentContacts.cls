/**
*  Description     :  This is the Apex class for Backend functioning for LWC component.
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  03/18/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/public with sharing class LwcComponentContacts {
    //this annotate is use for calling the Apex class from LWC component
    @AuraEnabled(cacheable=true)
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
    Public static List<Contact> getingContactRecords(){
        return [SELECT Id,Name,Phone FROM Contact WITH SECURITY_ENFORCED LIMIT 10];
    }

    
}
public with sharing class ContactWithImpertiveApexCall {
    /**
    * 
    *   @description    :   In this method we are not taking any argument and just returning the String.
    *
    *   @args           :   
    *
    *   @return         :   String
    *
    *   @revision Log   :   V1.1 - Created  - 03/22/2021 - Rajat khatri
    * 
    **/
    //this annotate is use for calling the Apex class from LWC component
    @AuraEnabled(cacheable=true)
    public static List<Contact> contactWithImpertive(String nameString) {
        String searchKey='%' + nameString + '%';
        return [SELECT Id,Email,Phone FROM Contact WHERE Name LIKE :searchKey];
    }
}
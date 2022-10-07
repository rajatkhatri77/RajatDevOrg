/**
*  Description     :  This is the Apex class for Backend functioning for LWC component for TileViewWithFlexiregionInfo
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  04/03/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
public with sharing class TileViewWithFlexiregionInfoControler {
    /**
    * 
    *   @description    :   In this method we not taking any argument returning the list of Contacts that and i will call this function from the lwc component
    *
    *   @args           :   
    *
    *   @return         :   List<Contact>
    *
    *   @revision Log   :   V1.1 - Created  - 04/03/2021 - Rajat khatri
    * 
    **/
    @AuraEnabled(cacheable=true)
    public static List<Contact> getRecordsOfContacts(){
        return [SELECT Id, Name, Phone, Email, Title FROM Contact];
    }
}
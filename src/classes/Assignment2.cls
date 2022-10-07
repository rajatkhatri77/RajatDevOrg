/**
*  Description     :  This is Assignment 2 apex class and in this we will using SOQL
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  01/12/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/public with sharing class Assignment2 {

    /**
    * 
    *   @description    :   In this method we are taking account id and returning the list of contact associated with that Id.
    *
    *   @args           :   String Account id
    *
    *   @return         :   List of contact associated with that Id given in argument.
    *
    *   @revision Log   :   V1.1 - Created  - 01/12/2021 - Rajat khatri
    * 
    **/
    public static List<Contact> listContact( string accountid){
        List<Contact> con = [SELECT Id,Name FROM Contact WHERE AccountId=:accountid];
        System.debug('List<Contact> ' + con);
        return con;
    }
    //This account list to pass argument in next method
   
    
    /**
    * 
    *   @description    :   In this method we are taking list of account and returning the map key as account id and value as list of contact in tha account.
    *
    *   @args           :   List of account
    *
    *   @return         :   Map in which key as id of account and value as list of contats in that account
    *
    *   @revision Log   :   V1.1 - Created  - 01/12/2021 - Rajat khatri
    * 
    **/
    public static Map<Id,List<Contact>> mapAccountWithContact( List<Account> accounts){
        
        Map<Id,List<Contact>> mapIdwithContact = new Map<Id,List<Contact>>();
        List<Contact> contact = [SELECT Id,Name,AccountId FROM Contact WHERE AccountId IN :accounts];
        for(Contact con : contact){
            if(!mapIdwithContact.containskey(con.AccountId)){
                mapIdwithContact.put(con.AccountId,new List<Contact> ());
            }
            mapIdwithContact.get(con.AccountId).add(con);
        }
        System.debug('Map<Id,List<Contact>> ' + mapIdwithContact);
        return mapIdwithContact;
    }
}
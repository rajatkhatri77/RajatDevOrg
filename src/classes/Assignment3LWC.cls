/**
*  Description     :  This is the Apex class for Backend functioning for LWC component for Assigment3
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  03/27/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
public with sharing class Assignment3LWC {
    //account Wrapper Object
    public static AccountsWrapper accountWrapperObject;
    //account Wrapper List
    public static List<AccountsWrapper> listWrapperForAccounts = new List<AccountsWrapper>();

    //contact Wrapper object
    public static ContactsWrapper contactWrapperObject;
    //contact Wrapper List
    public static List<ContactsWrapper> listWrapperForContacts = new List<ContactsWrapper>();


    //opportunity Wrapper object
    public static OpportunitiesWrapper opportunityWrapperObject;
    //opportunity Wrapper List
    public static List<OpportunitiesWrapper> listWrapperForopportunities = new List<OpportunitiesWrapper>();

    public static List<Account> allRecordsOfAccount = [SELECT Id, Name, BillingStreet, CreatedDate, RecordType.Name FROM Account];

    /**
    * 
    *   @description    :   In this method we not takin any argument returning the list of Accounts that and i will call this function from the lwc ldataServiceDeleteRecord
    *
    *   @args           :   
    *
    *   @return         :   List<Account>
    *
    *   @revision Log   :   V1.1 - Created  - 03/27/2021 - Rajat khatri
    * 
    **/
    @AuraEnabled(cacheable=true)
    public static List<AccountsWrapper> getRecordsOfAccounts(){


        for(Account accListElement : allRecordsOfAccount) {
            accountWrapperObject = new AccountsWrapper();
            accountWrapperObject.idAccount = accListElement.Id;
            accountWrapperObject.sName = accListElement.Name;
            accountWrapperObject.sBillingStreet = accListElement.BillingStreet;
            accountWrapperObject.dCreatedDate = accListElement.CreatedDate;
            accountWrapperObject.sRecordTypeName = accListElement.RecordType.Name;
            listWrapperForAccounts.add(accountWrapperObject);
        }
        return listWrapperForAccounts;
    }
    /**
    * 
    *   @description    :   In this method we not takin any argument returning the list of Contacts that and i will call this function from the lwc ldataServiceDeleteRecord
    *
    *   @args           :   
    *
    *   @return         :   List<Contact>
    *
    *   @revision Log   :   V1.1 - Created  - 03/30/2021 - Rajat khatri
    * 
    **/
    @AuraEnabled(cacheable=true)
    public static List<ContactsWrapper> getRecordsOfContacts(){

        List<Contact> allContactsRealtedAccounts = [SELECT Id, Name, Account.Name, CreatedDate, Email FROM Contact WHERE AccountId in : allRecordsOfAccount];
        for(Contact conListElement : allContactsRealtedAccounts) {
            contactWrapperObject = new ContactsWrapper();
            contactWrapperObject.idContact = conListElement.Id;
            contactWrapperObject.sName = conListElement.Name;
            contactWrapperObject.sAccountName = conListElement.Account.Name;
            contactWrapperObject.dCreatedDate = conListElement.CreatedDate;
            contactWrapperObject.sEmail = conListElement.Email;
            listWrapperForContacts.add(contactWrapperObject);
        }
        return listWrapperForContacts;
    }

    /**
    * 
    *   @description    :   In this method we not takin any argument returning the list of Contacts that and i will call this function from the lwc ldataServiceDeleteRecord
    *
    *   @args           :   
    *
    *   @return         :   List<Opportunity>
    *
    *   @revision Log   :   V1.1 - Created  - 03/30/2021 - Rajat khatri
    * 
    **/
    @AuraEnabled(cacheable=true)
    public static List<OpportunitiesWrapper> getRecordsOfOpportunity(){
        List<Opportunity> allOpportunitiesRelatedAccounts = [SELECT Id, Name, Account.Name, CreatedDate FROM Opportunity WHERE AccountId in : allRecordsOfAccount];
        for(Opportunity oppListElement : allOpportunitiesRelatedAccounts) {
            opportunityWrapperObject = new OpportunitiesWrapper();
            opportunityWrapperObject.idOpportunity = oppListElement.Id;
            opportunityWrapperObject.sName = oppListElement.Name;
            opportunityWrapperObject.sAccountName = oppListElement.Account.Name;
            opportunityWrapperObject.dCreatedDate = oppListElement.CreatedDate;
            listWrapperForopportunities.add(opportunityWrapperObject);
        }

        return listWrapperForopportunities;
    }



    
    //wrapper class for Account records
    public class AccountsWrapper{
        @AuraEnabled public Id idAccount;
        @AuraEnabled public String sName;
        @AuraEnabled public String sBillingStreet;
        @AuraEnabled public Datetime dCreatedDate;
        @AuraEnabled public String sRecordTypeName;
    }
    
    //wrapper class for Contact records
    public class ContactsWrapper{
        @AuraEnabled public Id idContact;
        @AuraEnabled public String sName;
        @AuraEnabled public String sAccountName;
        @AuraEnabled public Datetime dCreatedDate;
        @AuraEnabled public String sEmail;
    }

    //wrapper class for Opportunity records
    public class OpportunitiesWrapper{
        @AuraEnabled public Id idOpportunity;
        @AuraEnabled public String sName;
        @AuraEnabled public String sAccountName;
        @AuraEnabled public Datetime dCreatedDate;
    }
    @AuraEnabled(cacheable=true)
    public static Account getSingleAccount(){
        return [
            SELECT Id, Name, Phone, Type
            FROM Account
            WITH SECURITY_ENFORCED
            LIMIT 1
        ];
    }


}
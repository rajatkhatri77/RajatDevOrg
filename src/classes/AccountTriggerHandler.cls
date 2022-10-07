/**
*  Description     :  This is Account trigger handler class.
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  01/22/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
public with sharing class AccountTriggerHandler {
    /**
    * 
    *   @description    :   In this method we are adding the values on Account field.
    *
    *   @args           :   List of Accounts.
    *
    *   @return         :   
    *
    *   @revision Log   :   V1.1 - Created  - 01/22/2021 - Rajat khatri
    * 
    **/
    public static void addingFieldAAndFieldB(List<Account> accountList){
        for(Account a : accountList){
            if(a.A__c != null && a.B__c != null){
                a.C__c = a.A__c + a.B__c;
            }
            else if(a.A__c == null && a.B__c != null){
                a.C__c = a.B__c;
            }
            else if(a.A__c != null && a.B__c == null){
                a.C__c = a.A__c;
            }
            else{
                a.C__c = null;
            }
            System.debug('sum-> ' + a.C__c);
        }
    }
    /**
    * 
    *   @description    :   In this method we are creating cotact on account If Checkbox field is true and if checkbox field is false then delete that contact.
    *
    *   @args           :   List of Accounts and old map of Account.
    *
    *   @return         :   
    *
    *   @revision Log   :   V1.1 - Created  - 01/23/2021 - Rajat khatri
    * 
    **/
    public static void creatingContactOnAccountWithLastName(List<Account> accountList, Map<Id,Account> mapOldAccount){
        //This list we have created to create contact which are checked in checkbox in Create Contact
        List<Contact> toInsertContact = new List<Contact>();
        //map to store the false case Accounts.
        Map<Id,String> toStoreFalseAccount = new Map<Id,String>();
        //This list we have created to Delete contact which are unchecked in checkbox in Create Contact
        List<Contact> toDeleteContact = new List<Contact>();
        //Iterate for loop on this list of Accounts
        for(Account a : accountList){
            //checking the condition of create contact is True.
            
            if(a.create_Contact__c == True && (mapOldAccount == null || a.create_Contact__c != mapOldAccount.get(a.Id).create_Contact__c)){
                //Create new Conatact
                Contact con = new Contact();
                con.LastName = a.Name;
                con.AccountId = a.Id;
                //Added this new created conatct in list that we want to insert.
                toInsertContact.add(con);
            }
            //checking the condition of create contact is False.
            if(a.create_Contact__c == False &&  (mapOldAccount != null && a.create_Contact__c != mapOldAccount.get(a.Id).create_Contact__c)){
                //False case Accounts are stored in map with Account Id as key and Account Name as value
                toStoreFalseAccount.put(a.Id,a.Name);
            }
        
                
        }//size check
        if(toStoreFalseAccount.size() > 0){
        //list is that we will fetch all the contact drom map with its key set
        List<Contact> con = [SELECT  LastName,AccountId FROM Contact WHERE AccountId IN : toStoreFalseAccount.keyset()];
        //Iterate for loop on this list contact and then checking the conditions.
        for(Contact c : con){
            //Checking the conditions on for that account which we want to delete.
            if(toStoreFalseAccount.containsKey(c.AccountId) && (c.LastName == toStoreFalseAccount.get(c.AccountId))){
                //Adding that contact to list of contacts which we want to delete.
                toDeleteContact.add(c);

            }
        }
    }
        //Checking the Size of list.
        if(toInsertContact.size() > 0){
            //inserting list if the size of list is greater then 0.
            insert toInsertContact;
        }
        //Checking the Size of list.
        if(toDeleteContact.size() > 0){
            //Deleting the list if the size of list is greater then 0.
            delete toDeleteContact;
        }
    }
    /**
    * 
    *   @description    :   In this method we are creating cotacts on account if any contact details in contact detail feild in account the creating account with Firstname, lastname and email.
    *
    *   @args           :   List of Accounts and old map of Account.
    *
    *   @return         :   
    *
    *   @revision Log   :   V1.1 - Created  - 01/26/2021 - Rajat khatri
    * 
    **/
    

    public static void contactDetailsInsertAndDeleteOnAccount(List<Account> accounts, Map<Id, Account> mapOldAccounts)
    {
        // Map<Id, List<Contact>> mapAccIdWithContacts = new Map<Id, List<Contact>>();
        Map<String, Contact> mapString = new Map<String, Contact>();

        //Set to hold accounts
        Set<Id> setAccountIds = new Set<Id>();

        //Set to hold account ids this we will use to remove the contacts that is not persent in contact details  field
        Set<Id> setAccountIdToRemoveContact =  new Set<Id>();
        
        //set to hold unique key for performing deletion on contact
        Set<String> setContactDetailsWithAccount  =  new Set<String>();

        //Loop over new Accounts
        for(Account acc: accounts)
        {
            //Check if we need to delete any of the existing contact
            if(mapOldAccounts != null && acc.Contact_Details__c != mapOldAccounts.get(acc.Id).Contact_Details__c && String.isNotBlank(mapOldAccounts.get(acc.Id).Contact_Details__c)){
                //Variables to hold the new contact Details  and old contact Details
                String newConDetails = acc.Contact_Details__c;
                String oldConDetails = mapOldAccounts.get(acc.Id).Contact_Details__c;
                Set<String> setOldContactDetails = new Set<String>();
                for(String s: oldConDetails.split('\n')){
                    setOldContactDetails.add(s.trim());
                }
                System.debug('#Set of old Contact Details: '+setOldContactDetails);
                if(String.isNotBlank(acc.Contact_Details__c)){
                    Set<String> setContactDetails = new Set<String>();
                    for(String s: newConDetails.split('\n')){
                        setContactDetails.add(s.trim());
                }
                System.debug('#Set of new Contact Details: '+setContactDetails);
                setOldContactDetails.removeAll(setContactDetails);
                }

                if(setOldContactDetails.size()>0){
                    setAccountIdToRemoveContact.add(acc.Id);
                    //loop over the setOldContactDetails
                    for(String oldContactDetailsString : setOldContactDetails){
                        String contactDetailsUniKey = acc.Id + '-' + oldContactDetailsString.substringBetween('FirstName= ', ', LastName') + '-'
                                                        +oldContactDetailsString.substringBetween('LastName = ', ', Email') + '-'
                                                        +oldContactDetailsString.substringBetween('Email = ',' .');
                        
                        setContactDetailsWithAccount.add(contactDetailsUniKey);

                    }
                }
            }
            //Check if we need to execute contact validation logic
            if(String.isNotBlank(acc.Contact_Details__c) && (mapOldAccounts == null || acc.Contact_Details__c != mapOldAccounts.get(acc.Id).Contact_Details__c)){
                //Variables to hold the new contact Details  and old contact Details
                String newConDetails = acc.Contact_Details__c;
                String oldConDetails = (mapOldAccounts != null) ? mapOldAccounts.get(acc.Id).Contact_Details__c : '';

                // System.debug('New Con Details: '+newConDetails);
                System.debug('Old Con Details: '+oldConDetails);

                Set<String> setContactDetails = new Set<String>();
                for(String s: newConDetails.split('\n')){
                    setContactDetails.add(s.trim());
                }
                System.debug('Set of new Contact Details: '+setContactDetails);
                Set<String> setOldContactDetails = new Set<String>();
                if(String.isNotBlank(oldConDetails)){
                for(String s: oldConDetails.split('\n')){
                    setOldContactDetails.add(s.trim());
                }
                System.debug('Set of old Contact Details: '+setOldContactDetails);
    
                setContactDetails.removeAll(setOldContactDetails);
            }
                System.debug('Set removing old contact details from new Contact DEtails: '+setContactDetails);
                
                for(String conDetail: setContactDetails)
                {
                    //Contact instance
                    Contact con = new Contact();

                    //Checking lastName is present or null
                    if(String.isNotBlank(conDetail.substringBetween('LastName = ', ', Email')))
                    {
                        //Add Contact Details
                        con.firstName = conDetail.substringBetween('FirstName= ', ', LastName');
                        con.lastName = conDetail.substringBetween('LastName = ', ', Email');
                        con.Email = conDetail.substringBetween('Email = ',' .');
                        con.AccountId = acc.Id;

                        String s = con.firstName + '-' + con.lastName +'-'+ con.Email + '-'+con.AccountId;
                        System.debug('Unique String s value: '+s);
                        mapString.put(s, con);
                        setAccountIds.add(con.AccountId);
                    }
                } 
            }
        }
        System.debug('Map Of String that creates contact: '+mapString);

        List<Contact> contactToDeleteOnAccount = new List<Contact>();
        //Check any delete operation need to perform
        if(setAccountIdToRemoveContact.size()>0){
            for(Contact con : [Select Id, FirstName,LastName,Email,AccountId from Contact Where AccountId In : setAccountIdToRemoveContact]){
                //Create a unique key
                String uniqueKey = con.AccountId + '-' + con.FirstName + '-' + con.LastName + '-' + con.Email;

                if(setContactDetailsWithAccount.contains(uniqueKey)){
                    contactToDeleteOnAccount.add(con);
                }
            }
        }
        

        if(mapString.size() > 0)
        {
            //SOQL query over the contacts to get the existing contacts to avoid duplicates
            List<Contact> listContact1 = [Select Id, FirstName,LastName,Email, AccountId FROM Contact WHERE AccountId =: setAccountIds];
            for(Contact con: listContact1)
            {
                String s =  con.firstName + '-' + con.lastName +'-'+ con.Email + '-'+con.AccountId;
                //MapOfContact is being checked whether it contains key email then that email will be removed from mapOfContact
                if(mapString.containsKey(s))
                {
                    mapString.remove(s);
                }
            }
        }  
        System.debug('Before DML map String: '+mapString);
        if(mapString.size() > 0)
        {
            insert mapString.values();  
        }
        //Deleting contacts
        if(contactToDeleteOnAccount.size()>0){
            delete contactToDeleteOnAccount;
        }
    }
    /**
    * 
    *   @description    :   In this method we are creating cotacts and Opportunity on account if any contact details and opportunity details in Contact/Opportunity Details detail feild in account the creating account with Firstname, lastname and email.
    *
    *   @args           :   List of Accounts and old map of Account.
    *
    *   @return         :   
    *
    *   @revision Log   :   V1.1 - Created  - 02/05/2021 - Rajat khatri
    * 
    **/
    public static void creatingContactAndOpportunityFromContOppFeild(List<Account> accounts, Map<Id, Account> mapOldAccounts){
        //map for storing the contacts with there unique string key
        Map<String, Contact> mapToCreateContact = new Map<String, Contact>();
        //map for storing the contact with there unique string key
        Map<String, Opportunity> mapToCreateOpportunity = new Map<String, Opportunity>();

        //set to store the values of contacts which we want to delete
        Set<String> setToDeleteContacts = new Set<String>();
        //set to store the values of opportunity which we want to delete
        Set<String> setToDeleteOpp = new Set<String>();

        //set to store the AccountIds of which we will use soql
        Set<Id> setAccountId = new Set<Id>();
        //set to store the AccountId of contacts and opportunity
        Set<Id> setAccountIdToRemovecontatsAndOpp = new Set<Id>();

        //set to store the conatct details 
        Set<String> contactDetailsNew = new Set<String>();
        //set to store the opportunity details
        Set<String> oppDetailsNew = new Set<String>();
        //set to store the old Contact details
        Set<String> contactDetailsOld = new Set<String>();
        //set to store the old opportunity
        Set<String> oppDetailsOld = new Set<String>();

        //set to store the new contact details for deleting
        Set<String> contactDetailsNewForDelete = new Set<String>();
        //set to store the new opportunity details for deleteing
        Set<String> oppDetailsNewForDelete = new Set<String>();
        //set to strore the old contact details for deleting
        Set<String> contactDetailsOldForDelete = new Set<String>();
        //set to store the old opportunity details for deleting
        Set<String> oppDetailsOldForDelete = new Set<String>();
        // contactDetailsNewForDelete = contactDetailsNew.clone();
        // oppDetailsNewForDelete =  oppDetailsNew.clone();    
        // contactDetailsOldForDelete = contactDetailsOld.clone();
        // oppDetailsOldForDelete = oppDetailsOld.clone();

        //Loop over new Accounts
        for(Account acc : accounts){
            //this part is for inserting the contacts and opportunity for contact opportunity 1
            if(String.isNotBlank(acc.Contact_Opportunity_Details_1__c) && (mapOldAccounts == null || acc.Contact_Opportunity_Details_1__c != mapOldAccounts.get(acc.Id).Contact_Opportunity_Details_1__c)){
                //this is the rawstring which we have got from feild
                List<String> rawstr =  acc.Contact_Opportunity_Details_1__c.split('\n');
                System.debug('raw string 1'+rawstr);
                //loop over rawstring and feltring the values on basis of contact details or opportuntity details
                for(String s : rawstr){
                    String s1 = s.substringBefore(' = ');
                    if(s1 == 'FirstName'){
                        contactDetailsNew.add(s.trim());
                    }
                    if( s1 == 'Name'){
                        oppDetailsNew.add(s.trim());
                    }
                }
                //if(String.isNotBlank(mapOldAccounts.get(acc.Id).Contact_Opportunity_Details_1__c)){
                    String tempstrholder = (mapOldAccounts != null) ? mapOldAccounts.get(acc.Id).Contact_Opportunity_Details_1__c : '';
                    //this is the raw string which we have got from the feild old values
                    List<String> rawstrforold = tempstrholder.split('\n');
                    System.debug('raw string1 for old' + rawstrforold);
                    //loop over rawstring and feltring the values on basis of contact details or opportuntity details
                    for(String str : rawstrforold){
                        String str1 = str.substringBefore(' = ');
                        if(str1 == 'FirstName'){
                            contactDetailsOld.add(str.trim());
                            }
                        if( str1 == 'Name'){
                            oppDetailsOld.add(str.trim());
                            }
                        }
                //}
            }
            //this part is for inserting the contacts and opportunity for contact opportunity 2
            if(String.isNotBlank(acc.Contact_Opportunity_Details_2__c) && (mapOldAccounts == null || acc.Contact_Opportunity_Details_2__c != mapOldAccounts.get(acc.Id).Contact_Opportunity_Details_2__c)){
                //String newConAndOppDetails = acc.Contact_Opportunity_Details_1__c;
                //this is the raw string which we have got from the feild new values
                List<String> rawstr1 =  acc.Contact_Opportunity_Details_2__c.split('\n');
                System.debug('raw string 2' + rawstr1);
                //loop over rawstring and feltring the values on basis of contact details or opportuntity details
                for(String s : rawstr1){
                    String s1 = s.substringBefore(' = ');
                    if(s1 == 'FirstName'){
                        contactDetailsNew.add(s.trim());
                    }
                    if( s1 == 'Name'){
                        oppDetailsNew.add(s.trim());
                    }
                }
                //if(String.isNotBlank(mapOldAccounts.get(acc.Id).Contact_Opportunity_Details_2__c)){
                    String tempstrholder1 = (mapOldAccounts != null) ? mapOldAccounts.get(acc.Id).Contact_Opportunity_Details_2__c : '';
                    //this is the raw string which we have got from the feild new values
                    List<String> rawstrforold1 = tempstrholder1.split('\n');
                    System.debug('raw string2 for old' + rawstrforold1);
                    //loop over rawstring and feltring the values on basis of contact details or opportuntity details
                    for(String str : rawstrforold1){
                        String str1 = str.substringBefore(' = ');
                        if(str1 == 'FirstName'){
                            contactDetailsOld.add(str.trim());
                            }
                        if( str1 == 'Name'){
                            oppDetailsOld.add(str.trim());
                            }
                        }
                //}
            }
            //cloning the set for deleting the contacts and comparing with old and new values
            contactDetailsNewForDelete = contactDetailsNew.clone();
            contactDetailsOldForDelete = contactDetailsOld.clone();

            //removing the old values from the set only new fresh values are felt which we want to insert
            contactDetailsNew.removeAll(contactDetailsOld);
            //looping over the contacts details
            if(contactDetailsNew.size() > 0){
                for(String conDetail: contactDetailsNew){
                    //creating instance of contact
                        Contact con = new Contact();
                        //checking the lastname of cantact that is not blank
                        if(String.isNotBlank(conDetail.substringBetween('LastName = ', ', Email')))
                        {
                            //Add Contact Details
                            con.firstName = conDetail.substringBetween('FirstName = ', ', LastName');
                            con.lastName = conDetail.substringBetween('LastName = ', ', Email');
                            con.Email = conDetail.substringAfter('Email = ');
                            con.AccountId = acc.Id;
                            //making the unique key for particular account
                            String key = con.firstName + '-' + con.lastName +'-'+ con.Email + '-'+con.AccountId;
                            System.debug('Unique String s value: '+key);
                            //putting the values in map
                            mapToCreateContact.put(key, con);
                            //adding the account id in set for uesing this for soql
                            setAccountId.add(acc.Id);
                        }
                    }
            }
            //removing the new contacts only left with the old contacts which we want to delete
            contactDetailsOldForDelete.removeAll(contactDetailsNewForDelete);
            //check size
            if(contactDetailsOldForDelete.size() > 0){
                //adding the values of AccountId that will help us in soql 
                setAccountIdToRemovecontatsAndOpp.add(acc.Id);
                //loop over the contact detais for old to delete
                for(String conDetailsForDelete : contactDetailsOldForDelete){
                    //creaing the unique key which we use to check that contac that contact is in that account or not
                    String contactstoDelete = conDetailsForDelete.substringBetween('FirstName = ', ', LastName') + '-' + conDetailsForDelete.substringBetween('LastName = ', ', Email') + '-' + conDetailsForDelete.substringAfter('Email = ') + '-' + acc.Id;
                    //adding the values in set
                    setToDeleteContacts.add(contactstoDelete);
                }
            }

                //cloning the set for deleting the contacts and comparing with old and new values
                oppDetailsNewForDelete =  oppDetailsNew.clone();
                oppDetailsOldForDelete = oppDetailsOld.clone();
                //removing the old values from the opportunity
                oppDetailsNew.removeAll(oppDetailsOld);

                if(oppDetailsNew.size() > 0){
                    for(String oppDetails : oppDetailsNew){
                        if(String.isNotBlank(oppDetails.substringBetween('Name = ', ', Type'))){
                            //creating the instance of the of opportunity
                            Opportunity opp = new Opportunity();
                            //adding the values to opportuntity
                            opp.Name = oppDetails.substringBetween('Name = ', ', Type');
                            opp.StageName = oppDetails.substringAfter(', Stage = ');
                            opp.Type = oppDetails.substringBetween(', Type = ', ', Stage');
                            opp.CloseDate = System.today();
                            opp.AccountId = acc.Id;
                            //making the unique key 
                            String oppkey = opp.Name + '-' + opp.StageName + '-' + opp.Type + '-' + opp.AccountId;
                            //putting the the values in map
                            mapToCreateOpportunity.put(oppkey,opp);
                            //adding the AccountId in set
                            setAccountId.add(acc.Id);
                        }
                    }
                }

                //deleting the new opportunity and left with the only the opportunitys which we want to delete 
                oppDetailsOldForDelete.removeAll(oppDetailsNewForDelete);
                if(oppDetailsOldForDelete.size() > 0){
                    //Adding the AccountId in set
                    setAccountIdToRemovecontatsAndOpp.add(acc.Id);
                    //loop over the opportunity of old details
                    for(String oppDetailsForDelete : oppDetailsOldForDelete){
                        String opportunitystoDelete = oppDetailsForDelete.substringBetween('Name = ', ', Type') + '-' + oppDetailsForDelete.substringAfter(', Stage = ') + '-' + oppDetailsForDelete.substringBetween(', Type = ', ', Stage') + '-' + acc.Id;
                        //adding the values in set to delete opportunity
                        setToDeleteOpp.add(opportunitystoDelete);
                    }
                }
            }
        // System.debug('Contact details -->' + contactDetailsNew);
        // System.debug('Contact details Old -->' + contactDetailsOld);
        // System.debug('Contact details which we need to insert-->' + contactDetailsNew);
        // System.debug('Map to insert the contact ->' + mapToCreateContact);
        // System.debug('opp details -->' + oppDetailsNew);
        // System.debug('opp details old-->' + oppDetailsOld);
        // System.debug('opp details which we need to insert -->' + oppDetailsNew);
        // System.debug('Map to insert the Opportunity ->' + mapToCreateOpportunity);

        if(mapToCreateContact.size() > 0){
            //SOQL query over the contacts to get the existing contacts to avoid duplicates
            List<Contact> listContact1 = [Select Id, FirstName,LastName,Email, AccountId FROM Contact WHERE AccountId =: setAccountId];
            //loop over the listcontact
            for(Contact con: listContact1)
            {
                //string to compare with set
                String s =  con.firstName + '-' + con.lastName +'-'+ con.Email + '-'+con.AccountId;
                //MapOfContact is being checked whether it contains key email then that email will be removed from mapOfContact
                if(mapToCreateContact.containsKey(s))
                {
                    mapToCreateContact.remove(s);
                }
            }
        }
        //check size
        if(mapToCreateContact.size() > 0)
        {
            //inserting the contact 
            insert mapToCreateContact.values();  
        }  
        
        if(mapToCreateOpportunity.size() > 0){
            //SOQL query over the contacts to get the existing contacts to avoid duplicates
            List<Opportunity> listOpportunity = [Select Id,Name,StageName,Type, AccountId FROM Opportunity WHERE AccountId =: setAccountId];
            for(Opportunity oppp : listOpportunity){
                String uOppkye =  oppp.Name + '-' + oppp.StageName + '-' + oppp.Type + '-' + oppp.AccountId;
                //MapOfContact is being checked whether it contains key email then that email will be removed from mapOfContact
                if(mapToCreateOpportunity.containsKey(uOppkye))
                {
                    mapToCreateOpportunity.remove(uOppkye);
                }
            }
        }
        //check size
        if(mapToCreateOpportunity.size() > 0)
        {
            //inserting the opportunity
            insert mapToCreateOpportunity.values();  
        }


        //list to delete the contact
        List<Contact> contactToDeleteOnAccount = new List<Contact>();
        //check size
        if(setAccountIdToRemovecontatsAndOpp.size() > 0){
            //loop over the list of contacts from soql
            for(Contact con : [Select Id, FirstName,LastName,Email,AccountId from Contact Where AccountId In : setAccountIdToRemovecontatsAndOpp]){
                //Create a unique key
                String uniqueKeyOfContact = con.FirstName + '-' + con.LastName + '-' + con.Email + '-' + con.AccountId;

                if(setToDeleteContacts.contains(uniqueKeyOfContact)){
                    //adding the the contact to list which we want to delete
                    contactToDeleteOnAccount.add(con);
                }
            }
        }
        //check size
        if(contactToDeleteOnAccount.size() > 0){
            //deleting the contacts
            delete contactToDeleteOnAccount;
        }

        //list to delete the opportunity
        List<Opportunity> OpportunityToDeleteOnAccount = new List<Opportunity>();
        if(setAccountIdToRemovecontatsAndOpp.size() > 0){
            //loop over the list of opportunity from soql
            for(Opportunity opport : [Select Id,Name,StageName,Type, AccountId FROM Opportunity WHERE AccountId =: setAccountIdToRemovecontatsAndOpp])
            {
                String uniqueKeyOfOpportunity = opport.Name + '-' + opport.StageName + '-' + opport.Type + '-' + opport.AccountId;

                if(setToDeleteOpp.contains(uniqueKeyOfOpportunity)){
                    //adding the opportunity to the list which we want to delete
                    OpportunityToDeleteOnAccount.add(opport);
                }
            }
        }
        //deleting the opportunity
        if(OpportunityToDeleteOnAccount.size() > 0){
            delete OpportunityToDeleteOnAccount;
        }

    }
}
/**
*  Description     :  This is Assignment 7 apex class and in this we will create a contact in account on which the Conatct details are entered
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  01/21/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
public with sharing class Assignment7 {
    /**
    * 
    *   @description    :   In this method we are taking Account List and thorugh that list checking if any contact details in contact detail feild in account the creating account with Firstname, lastname and email and then clearing the contact detail feild in aontacts.
    *
    *   @args           :   List of Accounts.
    *
    *   @return         :   
    *
    *   @revision Log   :   V1.1 - Created  - 01/21/2021 - Rajat khatri
    * 
    **/
    public static void creatingContactInAccount(List<Account> account){
        //list of Account to update Account contact field
        List<Account> updatingAccountList = new List<Account>();
        //List of Contact to insert contacts which data is given in contact details field on Account.
        List<Contact> con = new List<Contact>();
        //loop for Iterate on given Account list.
        for(Account acc : account){
            //storing the accountId in variable
            Id accId = acc.Id;
            //storing the Contact details in string for further converting the this string to list.
            String contDetails = acc.Contact_Details__c;
            //Converting the contact details in list.
            String[] contDetailsList = contDetails.split('\n');
            //loop for Iterate on list of contact details.
            for(String st : contDetailsList){
                //creating Contact which we will add in Contact list with data from which we want to create contact.
                Contact conn = new Contact();
                //entering the Firstname in from list using substring method.
                conn.FirstName = st.substringBetween('FirstName=',',LastName=');
                //entering the name in from list using substring method.
                conn.LastName = st.substringBetween(',LastName=',',Email=');
                //entering the Lastname in from list using substring method.
                conn.Email = st.substringAfter(',Email=');
                //assigning AccountId to Contact
                conn.AccountId = accId;
                //Adding the contact to Contact list.
                con.add(conn);
            }
            //creaing Account with the Accountid and adding account to account list.
            Account acnt = new Account(Id=accId);
            //updating the Contact details in Account field with none.
            acnt.Contact_Details__c = '';
            //Adding the account to Account list.
            updatingAccountList.add(acnt);
            
        }
        //Updating the Account list.
        update updatingAccountList;
        //Checking the if contact list is empty or not
        If(con.size() > 0){
            //printing the contact list
            System.debug(con);
            //Inserting the List of contact and contact in that list will be inserted to respective Accounts associated with contact.
            insert con;
        }
        
        
    }
       
    }
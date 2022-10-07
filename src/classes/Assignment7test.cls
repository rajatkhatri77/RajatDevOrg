/**
*  Description     :  This is Assignment 7 apex class and in this we will create a contact in account on which the Conatct details are entered
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  01/22/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
@isTest
public with sharing class Assignment7test {
    /**
    * 
    *   @description    :   In this method we are creating the sample data on which our test class will work.
    *
    *   @args           :   
    *
    *   @return         :   
    *
    *   @revision Log   :   V1.1 - Created  - 01/22/2021 - Rajat khatri
    * 
    **/
    @testSetup static void setup() {
        Account acct = new Account();
        acct.Name = 'Salesforce.com';
        acct.Industry = 'Technology';
        acct.Contact_Details__c = 'FirstName=Ram,LastName=Sharma,Email=ram@gmail.com\nFirstName=Rajat,LastName=khatri,Email=rk@gmail.com';
        insert acct;
    }

    /**
    * 
    *   @description    :   In this method we are Executing the method of Assignment7 from this on the basis of sample data which we have created above.
    *
    *   @args           :   
    *
    *   @return         :   
    *
    *   @revision Log   :   V1.1 - Created  - 01/22/2021 - Rajat khatri
    * 
    **/
    @isTest static void testcreatingContactInAccount(){
        //This List of Account we will pass in argument.
        List<Account> account = [SELECT Id,Contact_Details__c FROM Account WHERE Account.Name = 'Salesforce.com'];
        //Test Execution of Assignment7 class on Sample data.
        Assignment7.creatingContactInAccount(account);
}
}
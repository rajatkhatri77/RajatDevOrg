/**
*  Description     :  This is test class of Assignment6 apex class and in this we have implement the All the KYC Status in contacts and in accounts as well.
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  01//2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
@isTest
public with sharing class Assignment6Test {
    @testSetup static void setup() {
        Account acct = new Account();
        acct.Name = 'Salesforce.com';
        acct.Industry = 'Technology';
        insert acct;
  
        Contact cont = new Contact();
        cont.FirstName = 'Amit';
        cont.LastName = 'Chaudhary';
        cont.AccountId = acct.Id;
        insert cont;

        KYC_Detail__c test1 = new KYC_Detail__c();
        test1.Status__c = 'Completed';
        test1.Contact__c = cont.Id;
        insert test1;

        KYC_Detail__c test2 = new KYC_Detail__c();
        test2.Status__c = 'Failed';
        test2.Contact__c = cont.Id;
        insert test2;

        KYC_Detail__c test3 = new KYC_Detail__c();
        test3.Status__c = 'In Progress';
        test3.Contact__c = cont.Id;
        insert test3;

        KYC_Detail__c test4 = new KYC_Detail__c();
        test4.Status__c = 'Not Started';
        test4.Contact__c = cont.Id;
        insert test4;

        Contact cont1 = new Contact();
        cont1.FirstName = 'Salman';
        cont1.LastName = 'khan';
        cont1.AccountId = acct.Id;
        insert cont1;

        KYC_Detail__c test5 = new KYC_Detail__c();
        test5.Status__c = 'Completed';
        test5.Contact__c = cont1.Id;
        insert test5;

        Contact cont2 = new Contact();
        cont2.FirstName = 'Salman1';
        cont2.LastName = 'khan1';
        cont2.AccountId = acct.Id;
        insert cont2;

        KYC_Detail__c test6 = new KYC_Detail__c();
        test6.Status__c = 'Completed';
        test6.Contact__c = cont2.Id;
        insert test6;

        Account acct1 = new Account();
        acct1.Name = 'Salesforce1.com';
        acct1.Industry = 'Technology';
        insert acct1;
  
        Contact cont3 = new Contact();
        cont3.FirstName = 'Amit1';
        cont3.LastName = 'Chaudhary1';
        cont3.AccountId = acct1.Id;
        insert cont3;

        KYC_Detail__c test7 = new KYC_Detail__c();
        test7.Status__c = 'Completed';
        test7.Contact__c = cont3.Id;
        insert test7;

        KYC_Detail__c test8 = new KYC_Detail__c();
        test8.Status__c = 'Completed';
        test8.Contact__c = cont3.Id;
        insert test8;

        Contact cont4 = new Contact();
        cont4.FirstName = 'Salman12';
        cont4.LastName = 'khan12';
        cont4.AccountId = acct1.Id;
        insert cont4;

        KYC_Detail__c test9 = new KYC_Detail__c();
        test9.Status__c = 'Completed';
        test9.Contact__c = cont4.Id;
        insert test9;

        Contact cont5 = new Contact();
        cont5.FirstName = 'Salman123';
        cont5.LastName = 'khan123';
        cont5.AccountId = acct1.Id;
        insert cont5;

        KYC_Detail__c test10 = new KYC_Detail__c();
        test10.Status__c = 'Failed';
        test10.Contact__c = cont5.Id;
        insert test10;
 }
    @isTest static void testKYCStatusAndFlag(){
        List<Contact> conn = [SELECT Id FROM Contact WHERE Account.Name = 'Salesforce.com'];
        Assignment6.kYCStatusAndFlag(conn);
    }
    @isTest static void testKYCStatusAndFlag1(){
        List<Contact> conn1 = [SELECT Id FROM Contact WHERE Account.Name = 'Salesforce1.com'];
        Assignment6.kYCStatusAndFlag(conn1);
    }
    
}
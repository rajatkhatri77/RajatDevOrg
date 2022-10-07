/**
*  Description     :  This is test class for GenericRelatedList
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  01/26/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
@isTest
public with sharing class Test_GenericRelatedListControler {
    @testsetup static void testSetupData(){
        Account acct = new Account();
        acct.Name = 'Salesforce.com';
        acct.Industry = 'Technology';
        insert acct;

        Contact cont = new Contact();
        cont.FirstName = 'Amit';
        cont.LastName = 'Chaudhary';
        cont.AccountId = acct.Id;
        cont.Email = 'amitch@lwc.com';
        cont.status__c = 'Active';
        insert cont;

        Contact cont1 = new Contact();
        cont1.FirstName = 'Amit';
        cont1.LastName = 'Chaudhary1';
        cont1.AccountId = acct.Id;
        cont1.Email = 'amitch1@lwc.com';
        cont1.status__c = 'Active';
        insert cont1;

        Testobject__c testobj1 = new Testobject__c();
        testobj1.Name = 'TestObjectLWC';
        testobj1.Account_Related__c = acct.Id;
        insert testobj1;

        Testobject__c testobj2 = new Testobject__c();
        testobj2.Name = 'TestObjectLWC';
        insert testobj2;


    }
    @isTest static void testfetchData(){
        List<Testobject__c> testobject = [Select Id,Name,Account_Related__c From Testobject__c ORDER BY Name ASC];

        String listValues = testobject[0].Id + '-' + 'Contact-' + 'AccountId In (Select Account_Related__c From Testobject__c Where Id =';
        String  columnsValues = 'Name-Name-text,Email-Email-email,Status__c-Status-text';

        GenericRelatedListControler.RelatedListDataWrapper reListdatawrapper = GenericRelatedListControler.fetchData(listValues, columnsValues);

        List<SObject> listrelatedata = reListdatawrapper.sobj;
        
        System.assertEquals(2, listrelatedata.size());



        listValues = testobject[1].Id + '-' + 'Contact-' + 'AccountId In (Select Account_Related__c From Testobject__c Where Id =';

        GenericRelatedListControler.RelatedListDataWrapper reListdatawrapper1 = GenericRelatedListControler.fetchData(listValues, columnsValues);

        listrelatedata = reListdatawrapper1.sobj;
        
        System.assertEquals(0, listrelatedata.size());





    }

}
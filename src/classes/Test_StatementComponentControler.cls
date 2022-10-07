/**
*  Description     :  Test Class for StatementControler
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  04/30/2021
*
*  Revision Logs   :   V1.0 - Created - Rajat khatri    
**/
@isTest
public with sharing class Test_StatementComponentControler {
    @testSetup
    static void setup(){
        Transaction_Limit__c TxLimit = new Transaction_Limit__c();
        TxLimit.Name = 'Test TxLimit';
        TxLimit.Maximum_Debit_Allowed_per_Day__c = 1000;
        TxLimit.Maximum_Debit_Allowed_per_Month__c = 15000;
        TxLimit.Maximum_Transactions_Allowed_per_Day__c = 4;
        TxLimit.Maximum_Transactions_Allowed_per_Month__c = 7;
        TxLimit.Maximum_Debit_Allowed_per_Transaction__c = 1000;
        insert TxLimit;

        Transaction_Limit__c TxLimit1 = new Transaction_Limit__c();
        TxLimit1.Name = 'Test TxLimit1';
        TxLimit1.Maximum_Debit_Allowed_per_Day__c = 10000;
        TxLimit1.Maximum_Debit_Allowed_per_Month__c = 150000;
        TxLimit1.Maximum_Transactions_Allowed_per_Day__c = 10;
        TxLimit1.Maximum_Transactions_Allowed_per_Month__c = 30;
        TxLimit1.Maximum_Debit_Allowed_per_Transaction__c = 5000;
        insert TxLimit1;

        Contact con = new Contact();
        con.LastName = 'Test Contact';
        con.Email = 'tessttContact@zyx.com';
        con.Status__c = 'Active';
        con.Transaction_Limit__c = TxLimit.Id;
        insert con;

        Contact con1 = new Contact();
        con1.LastName = 'Test Contact1';
        con1.Email = 'tessttContact1@zyx.com';
        con1.Status__c = 'Active';
        con1.Transaction_Limit__c = TxLimit1.Id;
        insert con1;

    

        List<Transaction_Entry__c> TxEntryList1 = new List<Transaction_Entry__c>();

        for(Integer i = 0; i < 5; i++){
            Transaction_Entry__c TxEntry = new Transaction_Entry__c();
            TxEntry.Transaction_Date__c = Date.today();
            TxEntry.Amount__c = 10000;
            TxEntry.Status__c = 'Completed';
            TxEntry.Type__c = 'Credit';
            TxEntry.Contact__c = con1.Id;
            TxEntryList1.add(TxEntry);
        }
        insert TxEntryList1;

        List<Transaction_Entry__c> TxEntryList2 = new List<Transaction_Entry__c>();

        for(Integer i = 0; i < 3; i++){
            Transaction_Entry__c TxEntry = new Transaction_Entry__c();
            TxEntry.Transaction_Date__c = Date.today();
            TxEntry.Amount__c = 100;
            TxEntry.Status__c = 'Completed';
            TxEntry.Type__c = 'Debit';
            TxEntry.Contact__c = con1.Id;
            TxEntryList2.add(TxEntry);
        }
        insert TxEntryList2;


        List<Transaction_Entry__c> TxEntryList3 = new List<Transaction_Entry__c>();

        for(Integer i = 0; i < 2; i++){
            Transaction_Entry__c TxEntry = new Transaction_Entry__c();
            TxEntry.Transaction_Date__c = Date.today();
            TxEntry.Amount__c = 2500;
            TxEntry.Status__c = 'Completed';
            TxEntry.Type__c = 'Credit';
            TxEntry.Contact__c = con.Id;
            TxEntryList3.add(TxEntry);
        }
        insert TxEntryList3;

        Transaction_Entry__c TxEntry4 = new Transaction_Entry__c();
        TxEntry4.Transaction_Date__c = Date.today();
        TxEntry4.Amount__c = 1000;
        TxEntry4.Status__c = 'Completed';
        TxEntry4.Type__c = 'Credit';
        TxEntry4.Contact__c = con.Id;
        insert TxEntry4;
        
        Transaction_Entry__c TxEntry5 = new Transaction_Entry__c();
        TxEntry5.Transaction_Date__c = Date.today();
        TxEntry5.Amount__c = 10;
        TxEntry5.Status__c = 'Completed';
        TxEntry5.Type__c = 'Debit';
        TxEntry5.Contact__c = con.Id;
        insert TxEntry5;
    }
    @isTest static void test_getTransactionEntries(){
        List<Contact> Con = [SELECT Id,Name FROM Contact ORDER BY LastName ASC];
        Test.startTest();
        Date startD = Date.parse('04/20/2021');
        Date endD = Date.parse('05/1/2021');
        List<Transaction_Entry__c> trnEntries = StatementComponentControler.getTransactionEntries(startD,endD,Con[0].Id);
        System.assertEquals(4, trnEntries.size());
        Date startD1 = Date.parse('01/20/2021');
        Date endD1 = Date.parse('05/1/2021');
        List<Transaction_Entry__c> trnEntries1 = StatementComponentControler.getTransactionEntries(startD1,endD1,Con[1].Id);
        System.assertEquals(8, trnEntries1.size());
        Test.stopTest();
    }

}
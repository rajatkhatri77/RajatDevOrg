@isTest
public with sharing class Test_BatchForMonthlyMail {
    
    @testSetup
    static void setup(){
       
        Transaction_Limit__c TxLimit = new Transaction_Limit__c();
        TxLimit.Name = 'Test TxLimit';
        TxLimit.Maximum_Debit_Allowed_per_Day__c = 1000;
        TxLimit.Maximum_Debit_Allowed_per_Month__c = 15000;
        TxLimit.Maximum_Transactions_Allowed_per_Day__c = 3;
        TxLimit.Maximum_Transactions_Allowed_per_Month__c = 7;
        TxLimit.Maximum_Debit_Allowed_per_Transaction__c = 1000;
        insert TxLimit;

        Contact con = new Contact();
        con.LastName = 'Test Contact';
        con.Email = 'rajat.khatri@fexle.com';
        con.Status__c = 'Active';
        con.Transaction_Limit__c = TxLimit.Id;
        insert con;

        Contact con1 = new Contact();
        con1.LastName = 'Test Contact1';
        con1.Email = 'rajatkhatri910@gmail.com';
        con1.Status__c = 'Active';
        con1.Transaction_Limit__c = TxLimit.Id;
        insert con1;

        List<Transaction_Entry__c> TxEntryList1 = new List<Transaction_Entry__c>();

        for(Integer i = 0; i < 3; i++){
            Transaction_Entry__c TxEntry = new Transaction_Entry__c();
            TxEntry.Transaction_Date__c = Date.today();
            TxEntry.Amount__c = 1000;
            TxEntry.Status__c = 'Completed';
            TxEntry.Type__c = 'Credit';
            TxEntry.Contact__c = con1.Id;
            TxEntryList1.add(TxEntry);
        }
        insert TxEntryList1;
    }

    @isTest
    static void testMethodForBatch(){

        Test.startTest();
        BatchForMonthlyMail obj = new BatchForMonthlyMail();
        DataBase.executeBatch(obj);
        Test.stopTest();
    }
}
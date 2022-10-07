@isTest//SELECT Id,Name FROM Contact WHERE FirstName = 'Test' ORDER BY Name ASC
public with sharing class Test_TransactionEntryTriggerHelper {
    @testSetup
    static void setup(){
		Test.setMock(HttpCalloutMock.class, new Test_qrCodeGeneretorMock());
        
        Transaction_Limit__c TxLimit1 = new Transaction_Limit__c();
        TxLimit1.Name = 'Test TxLimit1';
        TxLimit1.Maximum_Debit_Allowed_per_Day__c = 100000;
        TxLimit1.Maximum_Debit_Allowed_per_Month__c = 10000000;
        TxLimit1.Maximum_Transactions_Allowed_per_Day__c = 300;
        TxLimit1.Maximum_Transactions_Allowed_per_Month__c = 700;
        TxLimit1.Maximum_Debit_Allowed_per_Transaction__c = 10000;
        insert TxLimit1;
        
        Transaction_Limit__c TxLimit2 = new Transaction_Limit__c();
        TxLimit2.Name = 'Test TxLimit2';
        TxLimit2.Maximum_Debit_Allowed_per_Day__c = 1000;
        TxLimit2.Maximum_Debit_Allowed_per_Month__c = 10000;
        TxLimit2.Maximum_Transactions_Allowed_per_Day__c = 3;
        TxLimit2.Maximum_Transactions_Allowed_per_Month__c = 7;
        TxLimit2.Maximum_Debit_Allowed_per_Transaction__c = 1000;
        insert TxLimit2;

        
        Contact con = new Contact();
        con.LastName = 'Test Contact';
        con.Email = 'tessttContact@zyx.com';
        con.Status__c = 'Active';
        con.Transaction_Limit__c = TxLimit1.Id;
        insert con;
        
        Contact con1 = new Contact();
        con1.LastName = 'Test Contact1';
        con1.Email = 'tessttContact1@zyx.com';
        con1.Status__c = 'Active';
        con1.Transaction_Limit__c = TxLimit2.Id;
        insert con1;

    }

    static testMethod void test_validationOnTransactionEntries(){
        Contact con = [SELECT Id,Name, Available_Balance__c FROM Contact WHERE Email = 'tessttContact@zyx.com'];
        Contact con1 = [SELECT Id,Name, Available_Balance__c FROM Contact WHERE Email = 'tessttContact1@zyx.com'];
        
        Test.startTest();
        
        List<Transaction_Entry__c> txEntries1 = new List<Transaction_Entry__c>();
        for(Integer i = 0; i < 100; i++){
            Transaction_Entry__c txEntry = new Transaction_Entry__c();
            TxEntry.Transaction_Date__c = Date.today();
            TxEntry.Amount__c = 10000;
            TxEntry.Status__c = 'Completed';
            TxEntry.Type__c = 'Credit';
            TxEntry.Contact__c = con.Id;
            txEntries1.add(txEntry);
        }
        insert txEntries1;
        
        List<Transaction_Entry__c> txEntries2 = new List<Transaction_Entry__c>();
        for(Integer i = 0; i < 100; i++){
            Transaction_Entry__c txEntry = new Transaction_Entry__c();
            TxEntry.Transaction_Date__c = Date.today();
            TxEntry.Amount__c = 10;
            TxEntry.Status__c = 'Completed';
            TxEntry.Type__c = 'Debit';
            TxEntry.Contact__c = con.Id;
            txEntries2.add(txEntry);
        }
        insert txEntries2;
        
        List<Transaction_Entry__c> txEntries3 = new List<Transaction_Entry__c>();
        for(Integer i = 0; i < 10; i++){
            Transaction_Entry__c txEntry = new Transaction_Entry__c();
            TxEntry.Transaction_Date__c = Date.today();
            TxEntry.Amount__c = 10;
            TxEntry.Status__c = 'Pending';
            TxEntry.Type__c = 'Debit';
            TxEntry.Contact__c = con.Id;
            txEntries3.add(txEntry);
        }
        insert txEntries3;
        
        List<Transaction_Entry__c> txEntries4 = new List<Transaction_Entry__c>();
        for(Integer i = 0; i < 10; i++){
            Transaction_Entry__c txEntry = new Transaction_Entry__c();
            TxEntry.Transaction_Date__c = Date.today();
            TxEntry.Amount__c = 10;
            TxEntry.Status__c = 'Cancelled.';
            TxEntry.Type__c = 'Debit';
            TxEntry.Contact__c = con.Id;
            txEntries4.add(txEntry);
        }
        insert txEntries4;
        
        List<Transaction_Entry__c> txEntries5 = new List<Transaction_Entry__c>();
        for(Integer i = 0; i < 10; i++){
            Transaction_Entry__c txEntry = new Transaction_Entry__c();
            TxEntry.Transaction_Date__c = Date.today();
            TxEntry.Amount__c = 10;
            TxEntry.Status__c = 'Pending';
            TxEntry.Type__c = 'Credit';
            TxEntry.Contact__c = con.Id;
            txEntries5.add(txEntry);
        }
        insert txEntries5;
        
        List<Transaction_Entry__c> txEntries6 = new List<Transaction_Entry__c>();
        for(Integer i = 0; i < 10; i++){
            Transaction_Entry__c txEntry = new Transaction_Entry__c();
            TxEntry.Transaction_Date__c = Date.today();
            TxEntry.Amount__c = 10;
            TxEntry.Status__c = 'Cancelled.';
            TxEntry.Type__c = 'Credit';
            TxEntry.Contact__c = con.Id;
            txEntries6.add(txEntry);
        }
        insert txEntries6;
        
       
        List<Transaction_Entry__c> insertedTxEntries = [SELECT Id,Name FROM Transaction_Entry__c WHERE Contact__c =:con.Id];
        System.assertEquals(240,insertedTxEntries.size());
        
        Transaction_Entry__c txEntry = new Transaction_Entry__c();
            TxEntry.Transaction_Date__c = Date.today();
            TxEntry.Amount__c = 10000;
            TxEntry.Status__c = 'Completed';
            TxEntry.Type__c = 'Credit';
            TxEntry.Contact__c = con1.Id;
            insert txEntry;
        
        try{
            List<Transaction_Entry__c> txEntries7 = new List<Transaction_Entry__c>();
            txEntries7.add(new Transaction_Entry__c(Transaction_Date__c = Date.today(),Amount__c = 1000,Status__c = 'Completed',Type__c = 'Credit',Contact__c = con1.Id));
            txEntries7.add(new Transaction_Entry__c(Transaction_Date__c = Date.today(),Amount__c = 1000,Status__c = 'Completed',Type__c = 'Credit',Contact__c = con1.Id));
            txEntries7.add(new Transaction_Entry__c(Transaction_Date__c = Date.today(),Amount__c = 1000,Status__c = 'Completed',Type__c = 'Credit',Contact__c = con1.Id));
            insert txEntries7;
            
        }
        catch(Exception ex){
            System.assertEquals(true, ex.getMessage().contains('You can not credit/debit from your account, your today'+'\''+'s limit is exceeded.'));
        }
        
        Test.stopTest();        
    }
}
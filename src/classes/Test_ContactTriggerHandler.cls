@isTest
public class Test_ContactTriggerHandler {
    @testSetup
    static void setup(){
        Test.setMock(HttpCalloutMock.class, new Test_qrCodeGeneretorMock());
        List<Contact> contactsList = new List<Contact>();
        Transaction_Limit__c TxLimit = new Transaction_Limit__c();
        TxLimit.Name = 'Test TxLimit';
        TxLimit.Maximum_Debit_Allowed_per_Day__c = 1000;
        TxLimit.Maximum_Debit_Allowed_per_Month__c = 15000;
        TxLimit.Maximum_Transactions_Allowed_per_Day__c = 3;
        TxLimit.Maximum_Transactions_Allowed_per_Month__c = 7;
        TxLimit.Maximum_Debit_Allowed_per_Transaction__c = 1000;
        insert TxLimit;
        
        Contact con = new Contact();
        con.LastName = 'Test Contact1';
        con.Email = 'tessttContact@zyx.com';
        con.Status__c = 'Active';
        con.Transaction_Limit__c = TxLimit.Id;
        contactsList.add(con);

        con = new Contact();
        con.LastName = 'Test Contact2';
        con.Email = 'tessttContact1@zyx.com';
        con.Status__c = 'Active';
        con.Transaction_Limit__c = TxLimit.Id;
        contactsList.add(con);
        insert contactsList;
        
        Transaction_Entry__c txEntry = new Transaction_Entry__c();
        TxEntry.Transaction_Date__c = Date.today();
        TxEntry.Amount__c = 10000;
        TxEntry.Status__c = 'Completed';
        TxEntry.Type__c = 'Credit';
        TxEntry.Contact__c = contactsList[0].Id;
        insert txEntry;  
    }
    
    /*@isTest Static void test_qrCodeGenerator(){
        List<Contact> con = [SELECT Id,Name FROM Contact ORDER BY Name ASC];
        String jsonstr = json.serialize(con);
        Test.setMock(HttpCalloutMock.class, new Test_qrCodeGeneretorMock());
        ContactTriggerHandler.qrCodeGenerator(jsonstr);
        List<Attachment> attachmentList = [SELECT Id,Name FROM Attachment];
        System.assertEquals(2, attachmentList.size());
        
        
    }*/

}
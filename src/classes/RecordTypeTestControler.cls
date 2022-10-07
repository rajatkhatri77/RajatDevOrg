public with sharing class RecordTypeTestControler {
   
    public static RecordTypeTestControlerWrapper wrapperObject;
    
    public List<RecordTypeTestControlerWrapper> listWrapperForAccounts;

    public static List<RecordTypeTestControlerWrapper> listWrapperForAccounts = new List<RecordTypeTestControlerWrapper>();


    public class RecordTypeTestControlerWrapper{
        @AuraEnabled public Id idAccount;
        @AuraEnabled public String sName;
        @AuraEnabled public String sBillingStreet;
        @AuraEnabled public Datetime dCreatedDate;
        @AuraEnabled public String sRecordTypeName;
    }

    @AuraEnabled
    public static List<RecordTypeTestControlerWrapper> getRecordsOfAccountsFromWrapper(){

        for(Account accListElement : [SELECT Id, Name, BillingStreet, CreatedDate, RecordType.Name FROM Account]) {
            wrapperObject = new RecordTypeTestControlerWrapper();
            wrapperObject.idAccount = accListElement.Id;
            wrapperObject.sName = accListElement.Name;
            wrapperObject.sBillingStreet = accListElement.BillingStreet;
            wrapperObject.dCreatedDate = accListElement.CreatedDate;
            wrapperObject.sRecordTypeName = accListElement.RecordType.Name;
            listWrapperForAccounts.add(wrapperObject);
        }
        System.debug(listWrapperForAccounts);
        return listWrapperForAccounts;
}
}
@isTest
public class Test_TestFactory {

    public static testMethod void test_Factory(){
        System.debug('*********ACCOUNT**********');
        Account a = (Account)TestFactory.createSObject(new Account());
		insert a;
		System.debug(a);
	/*
        System.debug('*********ACCOUNT with Default Class**********');
        Account a2 = (Account)TestFactory.createSObject(new Account(),'TestFactoryDefaults.MyAccountDefaults');
		insert a2;
		System.debug(a2);

        System.debug('*********ACCOUNT WITH DO INSERT**********');
        Account a1 = (Account)TestFactory.createSObject(new Account(),true);
		System.debug(a1);

        System.debug('*********CONTACT**********');
        Contact con = (Contact)TestFactory.createSObject(new Contact(AccountId = a.Id));
        System.debug(con);
        insert con;

        System.debug('*********CONTACT WITH DO INSERT**********');
        Contact con1 = (Contact)TestFactory.createSObject(new Contact(AccountId = a.Id),true);
        System.debug(con1);

        System.debug('**********OPPORTUNITY*********');
        Opportunity opp = (Opportunity)TestFactory.createSObject(New Opportunity());
        Insert opp;
        System.debug(opp);
        
        System.debug('********ACCOUNT LIST***********');
		Account[] aList = (Account[])TestFactory.createSObjectList(new Account(), 5);
        
        System.debug('********ACCOUNT LIST***********');
		Account[] aList1 = (Account[])TestFactory.createSObjectList(new Account(), 5, 'TestFactoryDefaults.MyAccountDefaults',true);
        for(Account acc : aList1){
            System.debug(acc);
        }
        
        System.debug('*********CONTACT**********');
        Contact con = (Contact)TestFactory.createSObject(new Contact());
        System.debug(con);
        insert con;
        
        System.debug('*********TRANSACTION ENTRY**********');
        Transaction_Entry__c txEntry = (Transaction_Entry__c)TestFactory.createSObject(new Transaction_Entry__c(Contact__c = con.id));
        System.debug(txEntry);
        Transaction_Entry__c[] txEntryList = (Transaction_Entry__c[])TestFactory.createSObjectList(new Transaction_Entry__c(Contact__c = con.id),5);
        for(Transaction_Entry__c tx :txEntryList){System.debug(tx);}*/
    } 
    
}
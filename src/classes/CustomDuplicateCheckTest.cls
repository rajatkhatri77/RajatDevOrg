/**
*  Description     :  This is test class of Dynamic Apex in this we are passing list of sobject and checking if duplicate is there then we pass the Id of that duplicate in list of that sobjevt that we have passed.
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  02/23/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
@isTest
public inherited sharing class CustomDuplicateCheckTest {
    
    @isTest static void CustomDuplicateCheckmethodTest(){

        //creating custom duplicate rule object accounts
        List<Custom_Duplicate_Rule__c> listOfCustDupR = new List<Custom_Duplicate_Rule__c>();
        Custom_Duplicate_Rule__c cd = new Custom_Duplicate_Rule__c();
        cd.Object__c = 'Account';
        cd.Field__c = 'Name';
        listOfCustDupR.add(cd);

        Custom_Duplicate_Rule__c cd1 = new Custom_Duplicate_Rule__c();
        cd1.Object__c = 'Account';
        cd1.Field__c = 'Phone';
        listOfCustDupR.add(cd1);


        //creating the new records to check
        List<Account> listOfAccount = new List<Account>();
        Account acc12 = new Account();
        acc12.Name = 'rahul1';
        acc12.Phone = '123';
        listOfAccount.add(acc12);

        Account acc22 = new Account();
        acc22.Name = 'rahul1';
        acc22.Phone = '123';
        listOfAccount.add(acc22);

        Account acc32 = new Account();
        acc32.Name = 'rahul1';
        acc32.Phone = '123';
        listOfAccount.add(acc32);

        Test.startTest();
        insert listOfCustDupR;
        insert listOfAccount;

        List<Account> acc = [SELECT Id,Name,Phone,Exact_Custom_Duplicate__c FROM Account WHERE Id =:acc12.Id];
        CustomDuplicateCheck.CustomDuplicateCheckmethod1(acc);
        String str = acc22.Id + '\n' + acc32.Id;
        //System.assertEquals(str.trim(), acc32.Exact_Custom_Duplicate__c.trim());
        //System.assertEquals(str.trim(), String.valueOf(CustomDuplicateCheck.mapOrignamRecordWithDuplicate.get(acc12.Id)).trim());
        List<Account> account = [SELECT Id,Name,Phone,Exact_Custom_Duplicate__c FROM Account];
        for(Account acnt : account){
            if(String.isNotBlank(acnt.Exact_Custom_Duplicate__c)){
                System.assertEquals(str.trim(), String.valueOf(acnt.Exact_Custom_Duplicate__c).trim());
            }
        }

        test.stopTest();
    }
}
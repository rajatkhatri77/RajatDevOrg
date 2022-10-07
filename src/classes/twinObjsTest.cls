/**
*  Description     :  This is test class of twinObj in chich we have 2 custom field in they both have lookup relation on each other and checking the fieldset of both the objects and then we are checking the common fields and checking if child does not have same value as parent populating the same setfield the parents value.
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  03/01/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
@isTest
public inherited sharing class twinObjsTest {
    @testSetup static void setup() {
        Twin_Object2__c twin = new Twin_Object2__c();
        twin.Name = 'RK';
        twin.Date_T__c = System.today();
        insert twin;

        Twin_Object1__c twin1 = new Twin_Object1__c();
        twin1.Name = 'Rajat';
        twin1.txt__c = 'Rajat khatri';
        twin1.num__c = 1;
        twin1.Twin_Object2__c = twin.Id;
        insert twin1;

        Twin_Object1__c twin2 = new Twin_Object1__c();
        twin2.Name = 'Rahul';
        twin2.num__c = 1;
        insert twin2;
        
        Twin_Object2__c twin3 = new Twin_Object2__c();
        twin3.Name = 'KL Rahul';
        twin3.Date_T__c = System.today();
        twin3.txt__c = 'Kings punjab';
        twin3.Twin_Object1__c = twin2.Id;
        insert twin3;
    }
        @isTest  static void twintest(){
            Test.startTest();
            twinObj.twinObjs();
            List<Twin_Object2__c> twin2list = [SELECT Id,txt__c FROM Twin_Object2__c WHERE Name = 'RK'];
            List<Twin_Object1__c> twin1list = [SELECT Id,txt__c FROM Twin_Object1__c WHERE Name = 'Rajat'];
            List<Twin_Object1__c> twin3list = [SELECT Id,txt__c FROM Twin_Object1__c WHERE Name = 'Rahul'];
            List<Twin_Object2__c> twin4list = [SELECT Id,txt__c FROM Twin_Object2__c WHERE Name = 'KL Rahul'];
            System.assertEquals(twin1list[0].txt__c, twin2list[0].txt__c);
            System.assertEquals(twin3list[0].txt__c, twin4list[0].txt__c);
            test.stopTest();
        }
        
    }
/**
*  Description     :  This is test class of ContactTriggerHandler in this we will perform all the operations which are executed by the contactTriggerhandle.
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  01/29/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
@isTest
private with sharing class ContactTriggerHandlerTest {
    @isTest static void testcontactDuplicateAndPotentialDuplicateCheck(){

        //creating the contacts
        Contact con1 = new Contact(LastName = 'Jain',Email = 'ajain@gmail.com',Phone = '9000899911');
        Contact con2 = new Contact(LastName = 'Jethwani',Email = 'jethwani@gmail.com',Phone = '9000899911');
        Contact con3 = new Contact(LastName = 'singh',Email = 'ajain@gmail.com',Phone = '9000899911');
        Contact con4 = new Contact(LastName = 'Jethwani',Email = 'jethwani@gmail.com',Phone = '9000899911');
        Test.startTest();
        try{
            insert con2;
            Contact conn = [SELECT Id,Related_Duplicate__c,Potential_Duplicate__c FROM Contact WHERE Id =:con2.Id];
            System.assertEquals(False, conn.Potential_Duplicate__c);
            System.assertEquals(null, conn.Related_Duplicate__c);

            insert con1;
            Contact conn1 = [SELECT Id,Related_Duplicate__c,Potential_Duplicate__c FROM Contact WHERE Id =:con1.Id];
            System.assertEquals(False, conn1.Potential_Duplicate__c);
            System.assertEquals(null, conn1.Related_Duplicate__c);

            insert con3;
            Contact conn2 = [SELECT Id,Related_Duplicate__c,Potential_Duplicate__c FROM Contact WHERE Id =:con3.Id];
            System.assertEquals(true, conn2.Potential_Duplicate__c);
            System.assertEquals(1, conn2.Related_Duplicate__c.split('\n').size());

            insert con4;
            
        }
        catch(DmlException e){
            Boolean exceptionThrow = e.getMessage().contains('Use the Original contact rather then creating New One') ? true : false;
            System.assertEquals(true, exceptionThrow);
        }
        test.stopTest();
        
    
        }
}
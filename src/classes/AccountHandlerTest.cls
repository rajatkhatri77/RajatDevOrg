/**
*  Description     :  This is test class of AccountsTriggerHandler in this we will perform all the operations which are executed by the AccountTriggerhandle.
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  01/29/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
@isTest
public with sharing class AccountHandlerTest {
   
    @isTest static void testAddingFieldAAndFieldB(){
        //Insert case
        Account acc = new Account(Name = 'salesforce.com');
        acc.A__c = 10;
        acc.B__c = 10;
        Test.StartTest();
        insert acc;
        acc = [SELECT C__c FROM Account WHERE Name = 'salesforce.com'];
        System.debug('C__c :' + acc.C__c);
        System.assertEquals(20,acc.C__c);

        //updation case1
        acc.A__c = null;
        acc.B__c = 10;
        update acc;
        acc = [SELECT C__c FROM Account WHERE Name = 'salesforce.com'];
        System.debug('C__c :' + acc.C__c);
        System.assertEquals(10,acc.C__c);

        //updation case2
        acc.A__c = 10;
        acc.B__c = null;
        update acc;
        acc = [SELECT C__c FROM Account WHERE Name = 'salesforce.com'];
        System.debug('C__c :' + acc.C__c);
        System.assertEquals(10,acc.C__c);

        //updation case3
        acc.A__c = null;
        acc.B__c = null;
        update acc;
        acc = [SELECT C__c FROM Account WHERE Name = 'salesforce.com'];
        System.debug('C__c :' + acc.C__c);
        System.assertEquals(null,acc.C__c);
        Test.stopTest();

        }
        @isTest static void testCreatingContactOnAccountWithLastName(){
            Account acc = new Account(Name = 'salesforce.com');
            acc.create_Contact__c = true;
            Test.startTest();
            insert acc;
            System.assertEquals(1, [SELECT Count() FROM Contact WHERE lastName = 'salesforce.com']);

            acc.create_Contact__c = false;
            update acc;
            System.assertEquals(0, [SELECT Count() FROM Contact WHERE lastName = 'salesforce.com']);
            Test.stopTest();

        }
        @isTest static void testContactDetailsInsertAndDeleteOnAccount(){
            //for updation case inserting contact
            string contactDetails = 'FirstName= rajat1, LastName = khatri1, Email = rk1@gmail.com .\n'+
        'FirstName= rajat2, LastName = khatri2, Email = rk2@gmail.com .\n'+
        'FirstName= rajat3, LastName = khatri3, Email = rk3@gmail.com .\n'+
        'FirstName= rajat4, LastName = khatri4, Email = rk4@gmail.com .\n'+
        'FirstName= rajat5, LastName = khatri5, Email = rk5@gmail.com .\n';


        //for insertion case
        string contactDetails1 = 'FirstName= rajat1, LastName = khatri1, Email = rk1@gmail.com .\n'+
        'FirstName= rajat2, LastName = khatri2, Email = rk2@gmail.com .\n'+
        'FirstName= rajat3, LastName = khatri3, Email = rk3@gmail.com .\n'+
        'FirstName= rajat4, LastName = khatri4, Email = rk4@gmail.com .';

        //for deleting the contact in updation
        string contactDetails2 = 'FirstName= rajat1, LastName = khatri1, Email = rk1@gmail.com .\n'+
        'FirstName= rajat2, LastName = khatri2, Email = rk2@gmail.com .';


        //for deleting contacts in updation
        string contactDetails3 = null;

        
        //for inserting in updating
        string contactDetails4 = 'FirstName= rajat1, LastName = khatri1, Email = rk1@gmail.com .\n'+
        'FirstName= rajat2, LastName = khatri2, Email = rk2@gmail.com .';

        Account accnt = new Account(Name = 'Salesforce.com',Contact_Details__c = contactDetails1);
        List<String> listOfString = contactDetails1.split('\n');
        Test.startTest();
        insert accnt;
        List<Contact> listOfContact = [Select Id, FirstName,LastName,Email,AccountId from Contact Where AccountId = : accnt.Id];
        System.assertEquals(listOfString.size(),listOfContact.size());

        accnt.Contact_Details__c = contactDetails;
        List<String> listOfString1 = contactDetails.split('\n');
        update accnt;
        List<Contact> listOfContact1 = [Select Id, FirstName,LastName,Email,AccountId from Contact Where AccountId = : accnt.Id];
        System.assertEquals(listOfString1.size(),listOfContact1.size());

        accnt.Contact_Details__c = contactDetails2;
        List<String> listOfString2 = contactDetails2.split('\n');
        update accnt;
        List<Contact> listOfContact2 = [Select Id, FirstName,LastName,Email,AccountId from Contact Where AccountId = : accnt.Id];
        System.assertEquals(listOfString2.size(),listOfContact2.size());

        accnt.Contact_Details__c = contactDetails3;
        List<String> listOfString3 = new List<String>();
        update accnt;
        List<Contact> listOfContact3 = [Select Id, FirstName,LastName,Email,AccountId from Contact Where AccountId = : accnt.Id];
        System.assertEquals(listOfString3.size(),listOfContact3.size());

        accnt.Contact_Details__c = contactDetails4;
        List<String> listOfString4 = contactDetails4.split('\n');
        update accnt;
        List<Contact> listOfContact4 = [Select Id, FirstName,LastName,Email,AccountId from Contact Where AccountId = : accnt.Id];
        System.assertEquals(listOfString4.size(),listOfContact4.size());
        Test.stopTest();

    }
    @isTest static void testCreatingContactAndOpportunityFromContOppFeild(){
        String details1 = 'Contact Details :\n'+
        'FirstName = raman11, LastName = Sharma1, Email = raman11@gmail.com\n' +
        'FirstName = raman33, LastName = Sharma33, Email = raman33@gmail.com\n' +
        'FirstName = raman44, LastName = Sharma44, Email = raman44@gmail.com\n' +
        'Opportunity Details :\n' +
        'Name = TestOpp11, Type = Existing Customer - Upgrade, Stage = Prospecting\n' +
        'Name = OppTest11, Type = Existing Customer - Upgrade, Stage = Qualification';

        String details2 = 'Contact Details :\n'+
        'FirstName = raman55, LastName = Sharma55, Email = raman55@gmail.com\n' +
        'FirstName = raman66, LastName = Sharma66, Email = raman66@gmail.com\n' +
        'Opportunity Details :\n' +
        'Name = TestOpp22, Type = Existing Customer - Upgrade, Stage = Prospecting\n' +
        'Name = OppTest22, Type = Existing Customer - Upgrade, Stage = Qualification';

        String details11 = 'Contact Details :\n'+
        'FirstName = raman11, LastName = Sharma1, Email = raman11@gmail.com\n' +
        'FirstName = raman33, LastName = Sharma33, Email = raman33@gmail.com\n' +
        'FirstName = raman88, LastName = Sharma33, Email = raman88@gmail.com\n' +
        'FirstName = raman44, LastName = Sharma44, Email = raman44@gmail.com';

        String details22 = 'Opportunity Details :\n' +
        'Name = TestOpp22, Type = Existing Customer - Upgrade, Stage = Prospecting\n' +
        'Name = TestOpp33, Type = Existing Customer - Upgrade, Stage = Prospecting\n' +
        'Name = OppTest22, Type = Existing Customer - Upgrade, Stage = Qualification';


        String details111 = 'Contact Details :\n'+
        'FirstName = raman11, LastName = Sharma1, Email = raman11@gmail.com\n' +
        'FirstName = raman44, LastName = Sharma44, Email = raman44@gmail.com';

        String details222 = 'Opportunity Details :\n' +
        'Name = OppTest22, Type = Existing Customer - Upgrade, Stage = Qualification';

        Account accnt1 = new Account(Name = 'radhay sham',Contact_Opportunity_Details_1__c = details1,Contact_Opportunity_Details_2__c = details2);
        Test.startTest();
        insert accnt1;
        List<Contact> listOfContact = [Select Id, FirstName,LastName,Email,AccountId from Contact Where AccountId = : accnt1.Id];
        List<Opportunity> listOfopp = [Select Id, Name,Type,StageName,AccountId from Opportunity Where AccountId = : accnt1.Id];
        System.assertEquals(5,listOfContact.size());
        System.assertEquals(4,listOfopp.size());

        accnt1.Contact_Opportunity_Details_1__c = details11;
        accnt1.Contact_Opportunity_Details_2__c = details22;
        update accnt1;
        List<Contact> listOfContact1 = [Select Id, FirstName,LastName,Email,AccountId from Contact Where AccountId = : accnt1.Id];
        List<Opportunity> listOfopp1 = [Select Id, Name,Type,StageName,AccountId from Opportunity Where AccountId = : accnt1.Id];
        System.assertEquals(4,listOfContact1.size());
        System.assertEquals(3,listOfopp1.size());


        accnt1.Contact_Opportunity_Details_1__c = details111;
        accnt1.Contact_Opportunity_Details_2__c = details222;
        update accnt1;
        List<Contact> listOfContact2 = [Select Id, FirstName,LastName,Email,AccountId from Contact Where AccountId = : accnt1.Id];
        List<Opportunity> listOfopp2 = [Select Id, Name,Type,StageName,AccountId from Opportunity Where AccountId = : accnt1.Id];
        System.assertEquals(2,listOfContact2.size());
        System.assertEquals(1,listOfopp2.size());

        Test.stopTest();
    }

}
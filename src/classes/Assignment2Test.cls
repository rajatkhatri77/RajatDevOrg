/**
*  Description     :  This is test class of Assignmnet2
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  01/12/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/

@isTest
public with sharing class Assignment2Test {
    @isTest public static void testListContact(){
        Assignment2.listContact('0015g0000047zjLAAQ');
    }
    @isTest public static void testMapAccountWithContact(){
        List<Account> accounts = [SELECT Id,Name FROM Account WHERE Id='0015g0000047zjLAAQ' or Id='0015g0000047zjHAAQ'];
        Assignment2.mapAccountWithContact(accounts);
    }

}
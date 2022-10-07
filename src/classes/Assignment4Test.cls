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
public with sharing class Assignment4Test {
    @isTest public static void testSoqlEqual(){
        Assignment4.soqlEqual();
    }
    @isTest public static void testSoqlEqualWithVariable(){
        Assignment4.soqlEqualWithVariable();
    }
    @isTest public static void testSoqlNotEqual(){
        Assignment4.soqlNotEqual();
    }
    @isTest public static void testSoqlNotEqualWithVariable(){
        Assignment4.soqlNotEqualWithVariable();
    }
    @isTest public static void testSoqlINOperator(){
        Assignment4.soqlINOperator();
    }
    @isTest public static void testSoqlINOperatorWithVariable(){
        Assignment4.soqlINOperatorWithVariable();
    }
    @isTest public static void testSoqlLike(){
        Assignment4.soqlLike();
    }
    @isTest public static void testSoqlDate(){
        Assignment4.soqlDate();
    }
    @isTest public static void testSoqlDateTime(){
        Assignment4.soqlDateTime();
    }
    @isTest public static void testSoqlOrderBy(){
        Assignment4.soqlOrderBy();
    }
    
}
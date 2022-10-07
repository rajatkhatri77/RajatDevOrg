/**
*  Description     :  This is test class of my first apex class and in this we will perform Addition
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  01/07/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
@isTest
public with sharing class MyApexClassTest {
    
    @isTest static void testperformingAddition(){

        Integer x = MyApexClass.total;
        System.assertEquals(30,x);


        Integer y = MyApexClass.performingAddition1(50,50);
        System.assertEquals(100,y);
    }
    }
/**
*  Description     :  This is Assignment4 apex class and in this we will using SOQL creat some query.
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  01/12/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
public with sharing class Assignment4 {
    /**
    * 
    *   @description    :   In this method we are creating query using '='.
    *
    *   @args           :   
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 01/12/2021 - Rajat khatri
    * 
    **/
    public static void soqlEqual(){
        List<Contact> contacts =[SELECT Name,Department FROM Contact WHERE AccountId='0015g0000047zjHAAQ'];
        System.debug('SOQL using =' + contacts);
    }
     /**
    * 
    *   @description    :   In this method we are creating query using '='with variable.
    *
    *   @args           :   
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 01/12/2021 - Rajat khatri
    * 
    **/
    public static void soqlEqualWithVariable(){
        String targetDepartment = 'Production';
        List<Contact> contacts =[SELECT Name FROM Contact WHERE Department = 'Production'];
        System.debug('SOQL using with Variable =' + contacts);
    }
     /**
    * 
    *   @description    :   In this method we are creating query using '!='.
    *
    *   @args           :   
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 01/12/2021 - Rajat khatri
    * 
    **/
    public static void soqlNotEqual(){
        List<Contact> contacts =[SELECT Name,Department FROM Contact WHERE AccountId='0015g0000047zjHAAQ'];
        System.debug('SOQL using !=' + contacts);
    }
     /**
    * 
    *   @description    :   In this method we are creating query using '!=' with Variable.
    *
    *   @args           :   
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 01/12/2021 - Rajat khatri
    * 
    **/
    public static void soqlNotEqualWithVariable(){
        String targetDepartment = 'Production';
        List<Contact> contacts =[SELECT Name FROM Contact WHERE Department = 'Production'];
        System.debug('SOQL using with Variable !=' + contacts);
    }
     /**
    * 
    *   @description    :   In this method we are creating query using IN Operator.
    *
    *   @args           :   
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 01/12/2021 - Rajat khatri
    * 
    **/
    public static void soqlINOperator(){
        List<Account> accounts =[SELECT Name FROM Account WHERE Industry IN ('Apparel', 'Energy','Transportation')];
        System.debug('SOQL using IN Operator ' + accounts);
    
    }
     /**
    * 
    *   @description    :   In this method we are creating query using IN Operator with variable.
    *
    *   @args           :   
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 01/12/2021 - Rajat khatri
    * 
    **/
    public static void soqlINOperatorWithVariable(){
        List<String> acc = new List<String>{'Apparel','Energy','Transportation'};
        List<Account> accounts =[SELECT Name FROM Account WHERE Industry IN :acc];
        System.debug('SOQL using IN Operator ' + accounts);
    
    }
     /**
    * 
    *   @description    :   In this method we are creating query using LIKE Operator and its 3types.
    *
    *   @args           :   
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 01/12/2021 - Rajat khatri
    * 
    **/
    public static void soqlLike(){
        List<Account> account1 = [SELECT Id,Name FROM Account WHERE Name LIKE 'Raj%'];
        System.debug('SOQL Like operator: ' + account1);
        List<Account> account2 = [SELECT Id,Name FROM Account WHERE Name LIKE '%umar'];
        System.debug('SOQL Like operator: ' + account2);
        List<Account> account3 = [SELECT Id,Name FROM Account WHERE Name LIKE '%Salman khan%'];
        System.debug('SOQL Like operator: ' + account3);
    }
     /**
    * 
    *   @description    :   In this method we are creating query using Date filter.
    *
    *   @args           :   
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 01/12/2021 - Rajat khatri
    * 
    **/
    public static void soqlDate(){
        List<Account> account =[SELECT Id,Name FROM Account WHERE CreatedDate >  LAST_MONTH];
        System.debug('SOQL on DATE: ' + account);
    }
     /**
    * 
    *   @description    :   In this method we are creating query using Date/Time Filter.
    *
    *   @args           :   
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 01/12/2021 - Rajat khatri
    * 
    **/
    public static void soqlDateTime(){
        List<Account> account = [SELECT Id,Name FROM Account WHERE CreatedDate >  2021-01-06T01:02:03Z];
        System.debug('SOQL on Date/Time' + account);
    }
     /**
    * 
    *   @description    :   In this method we are creating query using Order by and its 2type.
    *
    *   @args           :   
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 01/12/2021 - Rajat khatri
    * 
    **/
    public static void soqlOrderBy(){
        List<Account> account = [SELECT Id,Name FROM Account ORDER BY CreatedDate ASC];
        System.debug('SOQL on Order By' + account);
        List<Account> account1 = [SELECT Id,Name FROM Account ORDER BY CreatedDate DESC];
        System.debug('SOQL on Order By' + account1);
    }
}
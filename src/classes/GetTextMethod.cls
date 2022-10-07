/**
*  Description     :  This is the Apex class for Apex + LWC
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  03/22/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
public with sharing class GetTextMethod {
    /**
    * 
    *   @description    :   In this method we are not taking any argument and just returning the String
    *
    *   @args           :   
    *
    *   @return         :   String
    *
    *   @revision Log   :   V1.1 - Created  - 03/22/2021 - Rajat khatri
    * 
    **/
    //this annotate is use for calling the Apex class from LWC component
    @AuraEnabled(cacheable=true)
    public static String getTextMethod1(){
        String method1 = 'METHOD-1';
        //returning the String
        return method1;
    }
    /**
    * 
    *   @description    :   In this method we are not taking any argument and just returning the String.
    *
    *   @args           :   
    *
    *   @return         :   String
    *
    *   @revision Log   :   V1.1 - Created  - 03/22/2021 - Rajat khatri
    * 
    **/
    //this annotate is use for calling the Apex class from LWC component
    @AuraEnabled(cacheable=true)
    public static String getTextMethod2(){
        //returning the String
        return 'METHOD-2';
    }   
    /**
    * 
    *   @description    :   In this method we are not taking any argument and just returning the String.
    *
    *   @args           :   
    *
    *   @return         :   String
    *
    *   @revision Log   :   V1.1 - Created  - 03/22/2021 - Rajat khatri
    * 
    **/
    //this annotate is use for calling the Apex class from LWC component
    @AuraEnabled(cacheable=true)
    public static String getTextMethod3(){
        //returning the String
        return 'METHOD-3';
    }

}
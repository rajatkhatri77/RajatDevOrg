/**
*  Description     :  This my first apex class and in this we will perform Addition
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  01/07/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
public with sharing class MyApexClass {

   //variables to for storing values
   static Integer int1 = 10;
   static Integer int2 = 20;
   public static Integer total;

   /**
    * 
    *   @description    :   To add the integer variables
    *
    *   @args           :   
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 01/07/2021 - Rajat khatri
    * 
    **/
    public static void performingAddition(){

        //Adding both of the Numbers into total
        total = int1 + int2;
    }

    /**
    * 
    *   @description    :   To add the integer variables
    *
    *   @args           :   2 integers in argument
    *
    *   @return         :   Integer
    *
    *   @revision Log   :   V1.1 - Created  - 01/07/2021 - Rajat khatri
    * 
    **/
    public static Integer performingAddition1( Integer int3, Integer int4 ){

        //Valiable we will return after performing Addition
        Integer int5 = 0;

        //Checking the value of both the integers are null or not
        if(int3 != null && int4 != null)
            int5 = int3 + int4;
        else if(int3 == null && int4 != null)
            int5 = int4;
        else if(int3 != null && int4 == null)
            int5 = int3;
        
        return int5;
    }
}
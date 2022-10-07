/**
*  Description     :  This is Assignment we are have 2 objects and they are have look up on each other and in common field set child should have same value as parent 
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  02/26/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
public without sharing class twinObj {
     /**
     * 
     *   @description    :   In this method we are checking the common fields and checking if child does not have same value as parent populating the same setfield the parents value.
     *
     *   @args           :   
     *
     *   @return         :   
     *
     *   @revision Log   :   V1.1 - Created  - 02/26/2021 - Rajat khatri
     * 
     **/
    public static void twinObjs() {
        //creating the set to keep the fieldset fields for twin_object1__c
        Set<String> obj1 = new Set<String>();
        //creating the set to keep the fieldset fields for twin_object2__c
        Set<String> obj2 = new Set<String>();

        //token of fieldset for twin_object1__c
        Schema.FieldSet fs1 = Schema.SObjectType.Twin_Object1__c.fieldSets.twinobj1;
        //making soql query to fetch all the records in twin_objetc1__c
        String SOQL1 = 'SELECT Id,Twin_Object2__c';
        //looping over the fields of fieldset for twin_object1__c
        for(Schema.FieldSetMember fsm1 : SObjectType.Twin_Object1__c.fieldSets.twinobj1.getFields()){
            //adding the field in Set
            obj1.add(fsm1.getFieldPath());
            //Adding the fields in soql
            SOQL1 += ',' + fsm1.getFieldPath();
        }
        SOQL1 += ' FROM Twin_Object1__c';
        System.debug(SOQL1);
        System.debug(obj1);

        //token of fieldset for twin_object2__c
        Schema.FieldSet fs2 = Schema.SObjectType.Twin_Object2__c.fieldSets.twinobj2;
        //making soql query to fetch all the records in twin_objetc2__c
        String SOQL2 = 'SELECT Id,Twin_Object1__c';
        //looping over the fields of fieldset for twin_object2__c
        for(Schema.FieldSetMember fsm2 : SObjectType.Twin_Object2__c.fieldSets.twinobj2.getFields()){
            //adding the field in Set
            obj2.add(fsm2.getFieldPath());
            //Adding the fields in soql
            SOQL2 += ',' + fsm2.getFieldPath();
        }
        SOQL2 += ' FROM Twin_Object2__c';
        System.debug(SOQL2);
        System.debug(obj2);


        //Set to store the common fields
        Set<String> commonFieldSet = new Set<String>();
        for(String str : obj1){
            if(obj2.contains(str)){
                commonFieldSet.add(str);
            }
        }

        System.debug(commonFieldSet);

        //Applying the soql on the Twin_Object1__c for fetching the records
        List<Twin_Object1__c> listObj1 = Database.query(SOQL1);
        System.debug(listObj1);
        //Applying the soql on the Twin_Object2__c for fetching the records
        List<Twin_Object2__c> listObj2 = Database.query(SOQL2);
        System.debug(listObj2);

        //creating list of Twin_Object2__c to update records
        List<Twin_Object2__c> listToUpdate1 = new List<Twin_Object2__c>();
        //looping over the records of Twin_Object1__c
        for(Twin_Object1__c twinobj1 : listObj1){
            //checking the lookup 
            if(twinobj1.Twin_Object2__c != null){
                //looping over the common fields
                for(String comnFields : commonFieldSet){
                    //creating the new record instance for Twin_Object2__c
                    Twin_Object2__c tobj1 = new Twin_Object2__c();
                    //adding the id of lookup record
                    tobj1.Id = twinobj1.Twin_Object2__c;
                    //adding the values of parent to child
                    tobj1.put(comnFields, twinobj1.get(comnFields));
                    System.debug(twinobj1.get(comnFields));
                    //adding the new record in list to update
                    listToUpdate1.add(tobj1);
                }
                
            }
        }
        System.debug(listToUpdate1);

        //creating list of Twin_Object1__c to update records
        List<Twin_Object1__c> listToUpdate2 = new List<Twin_Object1__c>();
        //looping over the records of Twin_Object2__c
        for(Twin_Object2__c twinobj2 : listObj2){
            //checking the lookup 
            if(twinobj2.Twin_Object1__c != null){
                //looping over the common fields
                for(String comnFields : commonFieldSet){
                    //creating the new record instance for Twin_Object1__c
                    Twin_Object1__c tobj2 = new Twin_Object1__c();
                    //adding the id of lookup record
                    tobj2.Id = twinobj2.Twin_Object1__c;
                    //adding the values of parent to child
                    tobj2.put(comnFields, twinobj2.get(comnFields));
                    System.debug(twinobj2.get(comnFields));
                    //adding the new record in list to update
                    listToUpdate2.add(tobj2);
                }
            }
        }

        System.debug(listToUpdate2);
        //checking the size of list to update
        if(listToUpdate1.size() > 0){
            update listToUpdate1;
        }

        //checking the size of list to update
        if(listToUpdate2.size() > 0){
            update listToUpdate2;
        }
    }
}
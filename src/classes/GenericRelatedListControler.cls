/**
*  Description     :  This is the Apex class for GenericRelatedList Component.
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  07/23/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
public with sharing class GenericRelatedListControler {
    // ColumnsWrapper Object
    public static ColumnsWrapper ColumnsWrapperObj;
    // List of ColumnsWrapper
    public Static List<ColumnsWrapper> columnsList = new List<ColumnsWrapper>();
    
    //RelatedListDataWrapper Object
    public static RelatedListDataWrapper RelatedListDataWrapperobj;

    // // cellAttributes Object
    // public static cellAttributes cellAttributesObj;

    //typeAttributes Object
    public static typeAttributes typeAttributesObj;

    //labels Object
    public static labels labelsObj;


    /**
    * 
    *   @description    :   In this method we are taking String as argument name columnsstring and sobject and where clause string.
    *
    *   @args           :   string
    *
    *   @return         :   RelatedListDataWrapper
    *
    *   @revision Log   :   V1.0 - Created  - 07/23/2021 - Rajat khatri
    * 
    **/
   
    @AuraEnabled(cacheable=true)
    public static RelatedListDataWrapper fetchData(String listValues, String fieldValues){
        
        //Set to store Field API Name
        List<String> listOfFields = new List<String>();
        //Sobject List to return records
        List<SObject> objList = new List<SObject>();
        //Set to store type of field
        Set<String> textTypeOfFields = new Set<String>{'PICKLIST','STRING','ADDRESS','TEXTAREA','MULTIPICKLIST'};

        //Checking Columns values are not blank
        if(String.isNotBlank(fieldValues)){
            
            //checking the String of Sobject and Where clause is not blank
            if(String.isNotBlank(listValues)){

                //Spliting the string with '-'
                List < String > strList = listValues.split( '-' ); 

                // Assigning the values in variable that can passed in argument
                String childobj = strList[0].trim();
                String Parentfield = strList[1].trim();
                String currentObjRelationToParentObj = strList[2].trim();
                String whereClause = strList[3].trim();
                String currentObj = strList[4].trim();
                String recordId = strList[5].trim();

                //Id is given or not
                if(fieldValues.contains('Id') || fieldValues.contains('id')){
                    String field = fieldValues;
                    //Calling the function to retrive data from Database
                    objList = fetchData1(field, childobj, Parentfield, currentObjRelationToParentObj, whereClause, currentObj, recordId);
                    
                }
                else{
                    String field = fieldValues + ',Id';
                    //Calling the function to retrive data from Database
                    objList = fetchData1(field, childobj, Parentfield, currentObjRelationToParentObj, whereClause, currentObj, recordId);
                    
                }

                //Spliting the values of fields
                listOfFields = fieldValues.split( ',' );
                System.debug(listOfFields);


                // Get Map of sObject's schema fields 
                // Map<API_Name, Schema.sObjectField> - Key is API name.
                Map<String, Schema.SObjectField> childObj_Schema_Field = Schema.getGlobalDescribe().get(childobj).getDescribe().fields.getMap();

                
                //Describing fields which we have passed in property
                for(String field_Name : listOfFields){

                    if(field_Name == 'Name'){
                        //Creating object for ColumnsWrapper
                        ColumnsWrapperObj = new ColumnsWrapper();
                        ColumnsWrapperObj.label = 'Name';
                        ColumnsWrapperObj.fieldName = 'nameUrl';   
                        ColumnsWrapperObj.type = 'url';
                        
                        labelsObj = new labels();
                        labelsObj.fieldName = 'Name';

                        typeAttributesObj = new typeAttributes();
                        typeAttributesObj.label = labelsObj;
                        typeAttributesObj.target = '_blank';

                        ColumnsWrapperObj.typeAttribute = typeAttributesObj;
                        //Adding the ColumnsWrapper in List
                        columnsList.add(ColumnsWrapperObj);

                    }
                    else{

                        Schema.DescribeFieldResult field_Description = childObj_Schema_Field.get( field_Name ).getDescribe();

                        //Creating object for ColumnsWrapper
                        ColumnsWrapperObj = new ColumnsWrapper();
                        ColumnsWrapperObj.label = field_Description.getLabel();
                        ColumnsWrapperObj.fieldName = field_Description.getName();
                        

                        if(textTypeOfFields.contains(String.valueOf(field_Description.getType()))){
                            ColumnsWrapperObj.type = 'text';
                        }
                        if(String.valueOf(field_Description.getType()) == 'EMAIL'){
                            ColumnsWrapperObj.type = 'email';
                        }
                        if(String.valueOf(field_Description.getType()) == 'PHONE'){
                            ColumnsWrapperObj.type = 'phone';
                        }
                        if(String.valueOf(field_Description.getType()) == 'URL'){
                            ColumnsWrapperObj.type = 'url';
                        }
                        if(String.valueOf(field_Description.getType()) == 'BOOLEAN'){
                            ColumnsWrapperObj.type = 'boolean';
                        }
                        if(String.valueOf(field_Description.getType()) == 'DATETIME' || String.valueOf(field_Description.getType()) == 'DATE'){
                            ColumnsWrapperObj.type = 'date';
                        }
                        if(String.valueOf(field_Description.getType()) == 'CURRENCY'){
                            ColumnsWrapperObj.type = 'currency';
                        }
                        if(String.valueOf(field_Description.getType()) == 'INTEGER' || String.valueOf(field_Description.getType()) == 'DOUBLE' || String.valueOf(field_Description.getType()) == 'PERCENT'){
                            ColumnsWrapperObj.type = 'number';
                        }
                        
                        System.debug('Cloumn of Table -> '+ColumnsWrapperObj);
                        //Adding the ColumnsWrapper in List
                        columnsList.add(ColumnsWrapperObj);

                    }
                    
                }
  
            }    
        }
        //Adding the values in Wrapper class
        RelatedListDataWrapperobj = new RelatedListDataWrapper();
        RelatedListDataWrapperobj.columns = columnsList;
        RelatedListDataWrapperobj.sobj = objList;
        if(objList.size() == 0){
            RelatedListDataWrapperobj.size = false;
            RelatedListDataWrapperobj.message = 'No Records associated with parent record';
        }else{
            RelatedListDataWrapperobj.size = true;
            RelatedListDataWrapperobj.message = '';
        }


        System.debug('RelatedListDataWrapperobj -> ' + RelatedListDataWrapperobj);
        return RelatedListDataWrapperobj;

    }
    /**
    * 
    *   @description    :   In this method we are taking String as argument of properties.
    *
    *   @args           :   string
    *
    *   @return         :   List<Sobject>
    *
    *   @revision Log   :   V1.0 - Created  - 08/02/2021 - Rajat khatri
    * 
    **/
     public static List<sObject> fetchData1(String fields, String childObj, String parenField, String currntObjRelationToParentObj, String whereClause, String currentObj, String recordId){

        String parentFieldAPIValue;
        String relatedListStr;
        List<sObject> currentObjRefrence = new List<sObject>();
        List<sObject> relatedList = new List<sObject>();

        //query string to get current object refrence with parent object
        String currentObjRefrenceStr = 'Select ' + currntObjRelationToParentObj + ' From ' + currentObj + ' Where Id =' + '\'' + recordId + '\'';
        currentObjRefrence = Database.query(currentObjRefrenceStr);

        //to get current object refrence value with Parent Object
        if(currntObjRelationToParentObj.contains('.')){
            // spliting String with '.' and using getSobject and get get value of refrence
            List < String > strList = currntObjRelationToParentObj.split( '\\.' ); 

            if(strList.size() == 2){
                parentFieldAPIValue = (String)currentObjRefrence[0].getSObject(strList[0]).get(strList[1]);
            }
            else if(strList.size() == 3){
                parentFieldAPIValue = (String)currentObjRefrence[0].getSObject(strList[0]).getSObject(strList[1]).get(strList[2]);
            }
            else if(strList.size() == 4){
                parentFieldAPIValue = (String)currentObjRefrence[0].getSObject(strList[0]).getSObject(strList[1]).getSObject(strList[2]).get(strList[3]);
            }
            else if(strList.size() == 5){
                parentFieldAPIValue = (String)currentObjRefrence[0].getSObject(strList[0]).getSObject(strList[1]).getSObject(strList[2]).getSObject(strList[3]).get(strList[4]);
            }
            else if(strList.size() == 6){
                parentFieldAPIValue = (String)currentObjRefrence[0].getSObject(strList[0]).getSObject(strList[1]).getSObject(strList[2]).getSObject(strList[3]).getSObject(strList[4]).get(strList[5]);
            }
            
        }
        //relatring is with direct Child
        else{
            parentFieldAPIValue = (String)currentObjRefrence[0].get(currntObjRelationToParentObj);
        }

        //When No where clause is given in property
        if(whereClause != 'NoWhereClause'){
            relatedListStr = 'Select ' + fields + ' From ' + childObj + ' Where ' + parenField + ' =' + '\'' + parentFieldAPIValue + '\'' + ' And ' + whereClause;           
        }
        else{
            relatedListStr = 'Select ' + fields + ' From ' + childObj + ' Where ' + parenField + ' =' + '\'' + parentFieldAPIValue + '\'';

        }
        relatedList = Database.query(relatedListStr);
        System.debug('relatedList -> ' + relatedList);

        return relatedList;
        
    }

    // Wrapper class to Columns
    public class ColumnsWrapper{
        @AuraEnabled public String fieldName;
        @AuraEnabled public String label;
        @AuraEnabled public String type;
        //@AuraEnabled public cellAttributes cellAttribute;
        @AuraEnabled public typeAttributes typeAttribute;
    }
    // Wrapper class to return data at client side.
    public class RelatedListDataWrapper{
        @AuraEnabled public List<ColumnsWrapper> columns;
        @AuraEnabled public List<SObject> sobj;
        @AuraEnabled public Boolean size;
        @AuraEnabled public String message;


    }
    // Wrapper class to return data at client side.
    public class typeAttributes{
        @AuraEnabled public labels label;
        @AuraEnabled public String target;

    }
    // Wrapper class to return data at client side.
    public class labels{
        @AuraEnabled public String fieldName;

    }
}
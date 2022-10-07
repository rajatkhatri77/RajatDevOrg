/**
*  Description     :  This is Assignment in chich we are chacking the duplicate rule for sObject by creating the custom object(Custom_Duplicate_Rule__c) and fiels in this object (Object__c,Field__c) and at the we are telling the account is Duplicate or not.
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  02/17/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
public without sharing class CustomDuplicateCheck {
    /**
    * 
    *   @description    :   In this method we are taking Sobject and then checking it wether it is Duplicate or not.
    *
    *   @args           :   Sobject
    *
    *   @return         :   
    *
    *   @revision Log   :   V1.1 - Created  - 02/17/2021 - Rajat khatri
    * 
    **/
    public static void CustomDuplicateCheckmethod(SObject sobjName) {
        //checking sobjName is not null
        if(sobjName != null){
            //checking the sobject type
            String argType = String.valueOf(sobjName.getSObjectType());

            //debugging the sobject type
            System.debug('argType->> ' + argType);

            //fetching the all the Fields from Customer Duplicate rule where object__c is sobjName
            List<Custom_Duplicate_Rule__c> argTypefromCDRobj = [SELECT Id,Object__c,Field__c FROM Custom_Duplicate_Rule__c WHERE Object__c =: argType];

            //debugging the list
            System.debug('List->' + argTypefromCDRobj);

            //creating the string which will check that from database
            String dynmicQueryStr = 'SELECT Id FROM ' + argType + ' WHERE ';  //**Id != \'' + sobjName.get('Id') + '\' AND '***

            //looping over the list of fields which we fetch from custom duplicate rule object
            for(Custom_Duplicate_Rule__c CDR : argTypefromCDRobj){
                dynmicQueryStr += CDR.Field__c + '=\'' + sobjName.get(CDR.Field__c) +'\' AND ';
            }

            //removing the and part from string which we will use for dynamic soql
            dynmicQueryStr = dynmicQueryStr.removeEnd(' AND ');
            System.debug('Dynamic SOQl -> '+ dynmicQueryStr);

            //applying dynamic Soql and fetching the records which are already exist or not.
            List<SObject> objList = Database.query(dynmicQueryStr);

            System.debug('Dynamic query List -> '+objList);
            if(objList.size() > 0){
                System.debug('It is Duplicate');
            }
            else{
                System.debug('It is not Duplicate');
            }
        }
        

        
    }
     /**
     * 
     *   @description    :   In this method we are taking Sobject and then checking it wether it is Duplicate or not.
     *
     *   @args           :   Sobject
     *
     *   @return         :   
     *
     *   @revision Log   :   V1.1 - Created  - 02/22/2021 - Rajat khatri
     * 
     **/
    public static Map<Id,String> mapOrignamRecordWithDuplicate = new Map<Id,String>();
    public static void CustomDuplicateCheckmethod1(List<SObject> sobjName){

        //Identify the sobject type
        String argType = String.valueOf(sobjName.getSObjectType());
        
        //Applying the soql quey to fetch the fields on which we want to check duplicate
        List<Custom_Duplicate_Rule__c> argTypefromCDRobj = [SELECT Id,Object__c,Field__c FROM Custom_Duplicate_Rule__c WHERE Object__c =: argType];

        //creating the map to store field names and record with respect to field
        Map<String,List<String>> mapToStoreDetails = new Map<String,List<String>>();

        //creating soql string which we will apply in dynamic soql
        String SOQL = 'SELECT ID,';

        //populating the maptostoredetails with fields(keys)
        for( Custom_Duplicate_Rule__c cDR : argTypefromCDRobj){
            mapToStoreDetails.put(cDR.Field__c, new List<String>());
            SOQL += cDR.Field__c + ',';
        }
        
        //list to store the ids of records which are passed in argument
        List<String> listIdsOfObj = new List<String>();

        //populating the listidsofobj
        for(SObject s : sobjName){
            listIdsOfObj.add('\''+ String.valueOf(s.Id) + '\'');
            for(String fieldName : mapToStoreDetails.keySet()){
                //populating the values of maptostoredetails with respect to fields(keys)
                mapToStoreDetails.get(fieldName).add('\''+ String.valueOf((s.get(fieldName)) + '\''));    
            }
        }

        //completing the string soql
        SOQL = SOQL.removeEnd(',') + ' FROM ' + argType + ' WHERE Id NOT IN ' + listIdsOfObj + ' AND ';

        //completing the where close of soql query which we will apply
        for(String str : mapToStoreDetails.keySet()){
            SOQL += str + ' IN ' + mapToStoreDetails.get(str) + ' AND ';
           
        }
        //removing the extra And from string
        SOQL = SOQL.removeEnd(' AND ');

        //duplicate records from database
        List<SObject> objList = Database.query(SOQL);
        System.debug(objList);
 
        //creating the map which will store the id of record which were passed in argument and value as id of duplicate records which came from database
                    ///declared above

        //creating the list which will use to updating the records with with exact duplicate records
        List<SObject> objToUpdate = new List<SObject>();

        //here we will create unique key of records which were passed in argument and and records which we got from the dynamic soql and populate the map
        for(SObject obj : sobjName){
            for(SObject dBobj : objList){
                String dBRecordUK = '';
                String oriRecordUk = '';
                for(String fieldAPIName : mapToStoreDetails.keySet()){
                    //creating unique keys
                    oriRecordUk += obj.get(fieldAPIName) + '-';
                    dBRecordUK += dBobj.get(fieldAPIName) + '-';
                }
                //comaring the keys which we have created accordingly populate the map
                if(String.isNotBlank(oriRecordUk) && String.isNotBlank(dBRecordUK) && dBRecordUK == oriRecordUk){
                    if(!mapOrignamRecordWithDuplicate.containsKey((Id)obj.get('Id'))){
                        mapOrignamRecordWithDuplicate.put((Id)obj.get('Id'),'');
                    }
                    mapOrignamRecordWithDuplicate.put((Id)obj.get('Id'), mapOrignamRecordWithDuplicate.get((Id)obj.get('Id')) + dBobj.get('Id') + '\n');
                }

            }

        }
        System.debug(mapOrignamRecordWithDuplicate);
        //here we are puting the value in Exact_Custom_Duplicate__c(field) from map(mapOrignamRecordWithDuplicate)
        for(Id ids : mapOrignamRecordWithDuplicate.keySet()){
            SObject DynamicObject = Schema.getGlobalDescribe().get(argType).newSObject();
            DynamicObject.Id = ids;
            DynamicObject.put('Exact_Custom_Duplicate__c', mapOrignamRecordWithDuplicate.get(ids));
            objToUpdate.add(DynamicObject);
        }

        //checking if the size
        if(objToUpdate.size() > 0){
            //updating the list
            update objToUpdate;
        }
        
    }       
}
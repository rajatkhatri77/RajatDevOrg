public with sharing class fargi {
    public static List<sObject> fetchData(String fields, String childObj, String parenField, String currntObjRelationToParentObj, String whereClause){

        String parentFieldAPIValue;
        List<sObject> currentObjRefrence = new List<sObject>();
        List<sObject> relatedList = new List<sObject>();

        String currentObjRefrenceStr = 'Select ' + currntObjRelationToParentObj + ' From testObj2__c Where Id =' + '\'' + 'a0D5g000002H90VEAS' + '\'';
        System.debug('currentObjRefrenceStr -> ' + currentObjRefrenceStr);

        currentObjRefrence = Database.query(currentObjRefrenceStr);
        System.debug('currentObjRefrence -> ' + currentObjRefrence);

        if(currntObjRelationToParentObj.contains('.')){
            System.debug('in contains if block');
            List < String > strList = currntObjRelationToParentObj.split( '\\.' ); 
            System.debug('splited the string');
            System.debug(strList);
            if(strList.size() == 2){
                parentFieldAPIValue = (String)currentObjRefrence[0].getSObject(strList[0]).get(strList[1]);
                System.debug('parentFieldAPIValue -> ' + parentFieldAPIValue);
            }
            else if(strList.size() == 3){
                parentFieldAPIValue = (String)currentObjRefrence[0].getSObject(strList[0]).getSObject(strList[1]).get(strList[2]);
                System.debug('parentFieldAPIValue -> ' + parentFieldAPIValue);
            }
            else if(strList.size() == 4){
                parentFieldAPIValue = (String)currentObjRefrence[0].getSObject(strList[0]).getSObject(strList[1]).getSObject(strList[2]).get(strList[3]);
                System.debug('parentFieldAPIValue -> ' + parentFieldAPIValue);
            }
            else if(strList.size() == 5){
                parentFieldAPIValue = (String)currentObjRefrence[0].getSObject(strList[0]).getSObject(strList[1]).getSObject(strList[2]).getSObject(strList[3]).get(strList[4]);
                System.debug('parentFieldAPIValue -> ' + parentFieldAPIValue);
            }
        }

        String relatedListStr = 'Select ' + fields + ' From ' + childObj + ' Where ' + parenField + ' =' + '\'' + parentFieldAPIValue + '\'';
        System.debug(relatedListStr);

        relatedList = Database.query(relatedListStr);
        System.debug(relatedList);

        return relatedList;
        
    }
}
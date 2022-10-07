public class testttttttttttt {
    public static void CustomDuplicateCheckmethod(List<SObject> sobjName){
        SObjectType var = sobjName.getSObjectType();
        String argType = String.valueOf(sobjName.getSObjectType());
            //debugging the sobject type
            System.debug('argType->> ' + argType);
           //System.debug(sobjName);
            List<Custom_Duplicate_Rule__c> argTypefromCDRobj = [SELECT Id,Object__c,Field__c FROM Custom_Duplicate_Rule__c WHERE Object__c =: argType];
        	System.debug('List->' + argTypefromCDRobj);
        Map<String,List<String>> mapToStoreDetails = new Map<String,List<String>>();
        for(Integer i=0 ;i < argTypefromCDRobj.size() ; i++){
            if(!mapToStoreDetails.containsKey(argTypefromCDRobj[i].Field__c)){
                mapToStoreDetails.put(argTypefromCDRobj[i].Field__c, new List<String>());
            } 
        }
        //mapToStoreDetails.put('Exact_Custom_Duplicate__c', new List<String>());
        //List<String> setId = new List<String>();
        for(SObject s : sobjName){
            //setId.add('\''+String.valueOf(s.Id)+ '\'');
            for(Integer i=0 ;i < argTypefromCDRobj.size() ; i++){
                mapToStoreDetails.get(argTypefromCDRobj[i].Field__c).add('\''+String.valueOf(s.get(argTypefromCDRobj[i].Field__c))+ '\'');
                System.debug(String.valueOf(s.get(argTypefromCDRobj[i].Field__c)));
            }
        }
       
        
        String soql = 'SELECT Id,Name,Phone,Exact_Custom_Duplicate__c FROM ' + argType + ' WHERE ';  //Id NOT IN ' + setId + ' AND '
        for(String str : mapToStoreDetails.keyset()){
            soql += str + ' IN ' + mapToStoreDetails.get(str) + ' AND ';
        }
        soql = soql.removeEnd(' AND ');
        System.debug(soql);
        List<Sobject> objList = Database.query(soql);
        //List<SObject> objList = Database.query(soql);
        System.debug('Dynamic query-> ' + objList);
        
        String y = '';
        for(String stt : mapToStoreDetails.keyset()){
            y +='True';
        }
        System.debug('COMPARE STRING--> '+ y);
        //Set<Id> setofId = new Set<Id>();
        //for(Sobject sobj : sobjName){
          //  setofId.add(sobj.Id);
        //}
        //String strrr = 'SELECT Id,Exact_Custom_Duplicate__c FROM '+ argType +' WHERE Id IN :' + setofId;
        //List<SObject> ss = Database.query(strrr);
        List<SObject> toUpdateList = new List<SObject>();
        if(objList.size() > 0){
            for(SObject s : objList){
                String z ='';
                String ab = '';
                for(SObject t : sobjName){
                    for(String str : mapToStoreDetails.keyset()){
                        
                        if(s.get(str)==t.get(str)){
                            z += 'True';
                            ab += str + ': ' + t.get(str) + ' ';
                        }
                        else{
                            z += 'False';
                        }
                    }
                    if(z == y){
                        System.debug('add' + t +'Account in Exact duplicate field of '+ s);
                    }
                   
                }
               System.debug(ab);
                SObject accc = Schema.getGlobalDescribe().get(argType).newSObject();
                //SObject acccc = new SObject(Id = s.Id,Exact_Custom_Duplicate__c = ab);
                accc.Id = s.Id;
                //accc.Exact_Custom_Duplicate__c = ab;
                toUpdateList.add(accc);
                System.debug(toUpdateList);
            }
        }
}
}
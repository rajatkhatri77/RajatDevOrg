/**
*  Description     :  This is Opportunity trigger helper class.
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  06/19/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
public class OpportunityTriggerHelper {
    /**
    * 
    *   @description    :   In this method we we are populating location field on contact associated with opportunity.
    *
    *   @args           :   List of Opportunity and Old map of Opportunity.
    *
    *   @return         :   
    *
    *   @revision Log   :   V1.1 - Created  - 06/19/2021 - Rajat khatri
    * 
    **/
    public static void updateContactLoaction(List<Opportunity> newOpp, Map<Id, Opportunity> oldOpp){
        //map to store ConIds With AccIds
        Map<Id,Set<Id>> mapConIdWithAccIds = new Map<Id,Set<Id>>();
        
        //list update contact
        List<Contact> contactToUpdate = new List<Contact>();
        System.debug('### New ### -> '+ newOpp);
        System.debug('### Old ### -> '+ oldOpp);
        
        List<Opportunity> oppList = newOpp != null ? newOpp : oldOpp.values();
        System.debug('oppList -> '+ oppList);
        List<Opportunity> oppListWithContactId = [Select Id,Name,AccountId,ContactId From Opportunity Where Id IN:oppList];
        //Insert,update and Delete case
        for(Opportunity opp : oppListWithContactId){
            System.debug(''+opp);
            if(opp.ContactId != null && (newOpp == null || oldOpp == null || 
                                         (newOpp != null && oldOpp != null && 
                                          (opp.AccountId != oldOpp.get(opp.Id).AccountId || opp.ContactId != oldOpp.get(opp.Id).ContactId))))
            {
                if(!mapConIdWithAccIds.containsKey(opp.ContactId))
                    mapConIdWithAccIds.put(opp.ContactId, new Set<Id>());
                if(opp.AccountId != null)
                	mapConIdWithAccIds.get(opp.ContactId).add(opp.AccountId);                            
            }
        }
        System.debug('mapConIdWithAccIds-> ' + mapConIdWithAccIds);
        if(mapConIdWithAccIds.size() > 0 && mapConIdWithAccIds.keySet().size() > 0){
            for(Opportunity opp1 : [Select Id,AccountId,ContactId From Opportunity Where ContactId IN : mapConIdWithAccIds.keySet()]){
                if(opp1.AccountId != null)
                    mapConIdWithAccIds.get(opp1.ContactId).add(opp1.AccountId);
            }
            for(Id conId : mapConIdWithAccIds.keySet()){
                contactToUpdate.add(new Contact(Id = ConId, Location1__c = mapConIdWithAccIds.get(ConId).size() > 1 ? 'Multiple' : mapConIdWithAccIds.get(ConId).size() == 1 ? 'Single' : ''));
            } 
            
        }
        System.debug('COntact to update-> ' + contactToUpdate);
        if(contactToUpdate.size() > 0){
            update contactToUpdate;
        }
    }
    
    /**
    * 
    *   @description    :   In this method we we are populating location field on contact associated with opportunity.
    *
    *   @args           :   List of Opportunity
    *
    *   @return         :   
    *
    *   @revision Log   :   V1.1 - Created  - 06/19/2021 - Rajat khatri
    * 
    **/
    public static void updateContactLoaction1(List<Opportunity> newOpp, Map<Id, Opportunity> oldOpp){
        
        //map to store ConIds With AccIds
        Map<Id,Set<Id>> mapConIdWithAccIds = new Map<Id,Set<Id>>();
        //Set of opportunities Id
        Set<Id> opportunityIds = new Set<Id>();
        
        //list update contact
        List<Contact> contactToUpdate = new List<Contact>();
        System.debug('### New ### -> '+ newOpp);
        System.debug('### old ### -> '+ oldOpp);
        
        List<Opportunity> oppList = newOpp != null ? newOpp : oldOpp.values();
        System.debug('oppList -> '+ oppList);
        List<Opportunity> oppListWithContactId = [Select Id,Name,AccountId,ContactId From Opportunity Where Id IN:oppList];
        
        //Insert,update and Delete case
        for(Opportunity opp : oppListWithContactId){
            System.debug('in opp loop -> '+opp);
            
            opportunityIds.add(opp.Id);
            
            if(!mapConIdWithAccIds.containsKey(opp.ContactId))
                mapConIdWithAccIds.put(opp.ContactId, new Set<Id>());                         
            
        }
        System.debug('mapConIdWithAccIds-> ' + mapConIdWithAccIds);
        if(mapConIdWithAccIds.size() > 0 && mapConIdWithAccIds.keySet().size() > 0){
            for(Opportunity opp1 : [Select Id,AccountId,ContactId From Opportunity Where ContactId IN : mapConIdWithAccIds.keySet() AND Id NOT IN:opportunityIds]){
                if(opp1.AccountId != null)
                    mapConIdWithAccIds.get(opp1.ContactId).add(opp1.AccountId);
            }
            for(Id conId : mapConIdWithAccIds.keySet()){
                contactToUpdate.add(new Contact(Id = ConId, Location1__c = mapConIdWithAccIds.get(ConId).size() > 1 ? 'Multiple' : mapConIdWithAccIds.get(ConId).size() == 1 ? 'Single' : ''));
            } 
            
        }
        System.debug('COntact to update-> ' + contactToUpdate);
        if(contactToUpdate.size() > 0){
            update contactToUpdate;
        }
        
    }
    /**
    * 
    *   @description    :   In this method we we are populating location field on contact associated with opportunity.
    *
    *   @args           :   List of Opportunity
    *
    *   @return         :   
    *
    *   @revision Log   :   V1.1 - Created  - 06/19/2021 - Rajat khatri
    * 
    **/
    public static void automobileRecordMaintenance(List<Opportunity> newOpp, Map<Id, Opportunity> oldMapOpp){
        String automobileSensorPrefix = '00:11:CE:00';
        String automobilePresenceSensorPrefix = '00:11:CE:D';
        String automobileTDUPrefix='00:11:CE:E';
        String automobileTagPrefix='XXX-XXX-XXX';
        
        List<Automobile_Sensor__c> automobileSensorRecodList = new List<Automobile_Sensor__c>();
        List<Automobile_Presence_Sensor__c> automobilePresenceSensorRecordList = new List<Automobile_Presence_Sensor__c>();
        List<Automobile_TDU__c> automobileTDURecordList = new List<Automobile_TDU__c>();
        
        for(Opportunity opp : newOpp){
            //insert and update condition
            if((opp.StageName == 'Shipped To Custome' || opp.StageName == 'Return to HQ' || opp.StageName == 'Retun to Customer') &&
               (oldMapOpp == null || opp.StageName != oldMapOpp.get(opp.Id).StageName)){
                   List<String> automobileRecordTextList = new List<String>();
                   //opp.Automobile_Tag_Details_1__c + '\n' + opp.Automobile_Tag_Details_2__c + '\n' + opp.Automobile_Tag_Details_3__c;
                   if(opp.Automobile_Tag_Details_1__c != null){
                       automobileRecordTextList.addAll(opp.Automobile_Tag_Details_1__c.split('\n'));
                   }
                   if(opp.Automobile_Tag_Details_2__c != null){
                       automobileRecordTextList.addAll(opp.Automobile_Tag_Details_2__c.split('\n'));
                   }
                   if(opp.Automobile_Tag_Details_3__c != null){
                       automobileRecordTextList.addAll(opp.Automobile_Tag_Details_3__c.split('\n'));
                   }
                   for(String AutomobileString : automobileRecordTextList){
                       if(AutomobileString.startsWith(automobileSensorPrefix)){
                           Automobile_Sensor__c automobileSensorRecord = new Automobile_Sensor__c();
                           if(opp.StageName == 'Shipped To Custome' || opp.StageName == 'Retun to Customer'){
                               if(AutomobileString.length() > 18){
                                   automobileSensorRecord.Name = AutomobileString.subString(0,18);
                               }else{
                                   automobileSensorRecord.Name = AutomobileString;
                               }
                               automobileSensorRecord.Account__c = opp.Installation_Account__c;
                               automobileSensorRecord.Opportunity__c = opp.Id;
                               
                           }else if(opp.StageName == 'Return to HQ'){
                                if(AutomobileString.length() > 18){
                                   automobileSensorRecord.Name = AutomobileString.subString(0,18);
                               }else{
                                   automobileSensorRecord.Name = AutomobileString;
                               }
                               automobileSensorRecord.Account__c = opp.Installation_Account__c;
                               automobileSensorRecord.Opportunity__c = opp.Id;
                               
                           }
                           automobileSensorRecodList.add(automobileSensorRecord);
                           
                       }
                       if(AutomobileString.startsWith(automobilePresenceSensorPrefix)){
                            Automobile_Presence_Sensor__c automobilePresenceSensorRecord = new Automobile_Presence_Sensor__c();
                           if(opp.StageName == 'Shipped To Custome' || opp.StageName == 'Retun to Customer'){
                               if(AutomobileString.length() > 18){
                                   automobilePresenceSensorRecord.Name = AutomobileString.subString(0,18);
                               }else{
                                   automobilePresenceSensorRecord.Name = AutomobileString;
                               }
                               automobilePresenceSensorRecord.Account__c = opp.Shipment_Account__c;
                               automobilePresenceSensorRecord.Opportunity__c = opp.Id;
                               
                           }else if(opp.StageName == 'Return to HQ'){
                                if(AutomobileString.length() > 18){
                                   automobilePresenceSensorRecord.Name = AutomobileString.subString(0,18);
                               }else{
                                   automobilePresenceSensorRecord.Name = AutomobileString;
                               }
                               automobilePresenceSensorRecord.Account__c = opp.Shipment_Account__c;
                               automobilePresenceSensorRecord.Opportunity__c = opp.Id;
                               
                           }
                           automobilePresenceSensorRecordList.add(automobilePresenceSensorRecord);
                           
                       }
                       if(AutomobileString.startsWith(automobileTDUPrefix)){
                           
                           Automobile_TDU__c automobileTDURecord = new Automobile_TDU__c();
                           if(opp.StageName == 'Shipped To Custome' || opp.StageName == 'Retun to Customer'){
                               if(AutomobileString.length() > 18){
                                   automobileTDURecord.Name = AutomobileString.subString(0,18);
                               }else{
                                   automobileTDURecord.Name = AutomobileString;
                               }
                               automobileTDURecord.Account__c = opp.Installation_Account__c;
                               automobileTDURecord.Opportunity__c = opp.Id;
                               
                           }else if(opp.StageName == 'Return to HQ'){
                                if(AutomobileString.length() > 18){
                                   automobileTDURecord.Name = AutomobileString.subString(0,18);
                               }else{
                                   automobileTDURecord.Name = AutomobileString;
                               }
                               automobileTDURecord.Account__c = opp.Shipment_Account__c;
                               automobileTDURecord.Opportunity__c = opp.Id;
                               
                           }
                           automobileTDURecordList.add(automobileTDURecord);
                           
                       }

                   }
                   
               }
        }
        if(automobileSensorRecodList.size() > 0){
            upsert automobileSensorRecodList;
        }
        if(automobilePresenceSensorRecordList.size() > 0){
            upsert automobileSensorRecodList;
        }
        if(automobileTDURecordList.size() > 0){
            upsert automobileSensorRecodList;
        }
        
    }
}
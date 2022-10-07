/**
*  Description     :  This is Assignment 6 apex class and in this we will using Aggregate query and finding the Status of kyc_ststus in in each contact and then after that  chacking for all the accounts which are having kya and according to that we will put flag on account.
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  01/18/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
public with sharing class Assignment6 {
    /**
    * 
    *   @description    :   In this method we are taking contact List and  applying aggregate query and checking the status of Kyc in contact and after the uodating that contatc status.
    *
    *   @args           :   List of Contact.
    *
    *   @return         :   
    *
    *   @revision Log   :   V1.1 - Created  - 01/18/2021 - Rajat khatri
    * 
    **/
    public static void kYCStatusAndFlag(List<Contact> conn){//
        //listbof aggregate query
        List<AggregateResult> agg = [SELECT Contact__c, Status__c,Count(Id) FROM KYC_Detail__c WHERE Contact__c IN : conn GROUP BY Contact__c,Status__c];//
        //map of Id and contact to update the contact KYC Status
        Map<Id,Map<string,Integer>> mapContact = new Map<Id,Map<string,Integer>>();
        //loop for Iterate aggregate query in map
        for(AggregateResult ar: agg){
            //variable for storing the Contact id.
            Id conId = (Id)ar.get('Contact__c');
            //Variable for storing the status from kyc_detail object
            String st = String.valueOf(ar.get('Status__c'));
        
            if(!mapContact.containsKey(conId)){
                mapContact.put(conId, new Map<string,Integer>());
                mapContact.get(conId).put('Green',0);
                mapContact.get(conId).put('Yellow',0);
                mapContact.get(conId).put('Red',0);
            }

            if(st == 'Completed'){
                //con.KYC_Status__c = 'Green';
                mapContact.get(conId).put('Green',mapContact.get(conId).get('Green')+1);
            }
            if(st == 'Failed'){
                //con.KYC_Status__c= 'Red';
                mapContact.get(conId).put('Red',mapContact.get(conId).get('Red')+1);
            }
            if(st == 'Not Started'){
                //con.KYC_Status__c = 'Yellow';
                mapContact.get(conId).put('Yellow',mapContact.get(conId).get('Yellow')+1);
            }
            if(st == 'In Progress'){
                //con.KYC_Status__c = 'Yellow';
                mapContact.get(conId).put('Yellow',mapContact.get(conId).get('Yellow')+1);
            }  
        }
        System.debug('------map-------'+ mapContact);


        //this contact list is to update the contact KYC status
        List<Contact> con = new List<Contact>();
        //Iterating list with map key set.
        for(Id cont : mapContact.keySet()){
            Contact ccc = new Contact(Id=cont);
            //Following are the condition checks for flag updation
            if(mapContact.get(cont).get('Yellow') == 0 && mapContact.get(cont).get('Red') == 0){
                ccc.KYC_Status__c = 'Green';
            }
            if(mapContact.get(cont).get('Yellow') == 0 && mapContact.get(cont).get('Green') == 0){
                ccc.KYC_Status__c = 'Red';
            }
            if(mapContact.get(cont).get('Green') == 0 && mapContact.get(cont).get('Red') == 0){
                ccc.KYC_Status__c = 'Yellow';
            }
            if(mapContact.get(cont).get('Green') != 0 && mapContact.get(cont).get('Red') != 0){
                ccc.KYC_Status__c = 'Yellow';
            }
            if(mapContact.get(cont).get('Yellow') != 0 && mapContact.get(cont).get('Green') != 0){
                ccc.KYC_Status__c = 'Yellow';
            }
            if(mapContact.get(cont).get('Yellow') != 0 && mapContact.get(cont).get('Red') != 0){
                ccc.KYC_Status__c = 'Yellow';
            }
            if(mapContact.get(cont).get('Yellow') != 0 && mapContact.get(cont).get('Green') != 0 && mapContact.get(cont).get('Red') != 0){
                ccc.KYC_Status__c = 'Yellow';
            }
            if(mapContact.get(cont).get('Yellow') == 0 && mapContact.get(cont).get('Green') == 0 && mapContact.get(cont).get('Red') == 0){
                ccc.KYC_Status__c = '';
            }
            //adding the conatct in list
            con.add(ccc);
        }
        //printing the Contact lis
        System.debug(con);
        //updating the Contacts with there values of kyc status and flag
        update con;

        
        //this list to update the Account kyc status and it will give us the Accountid of that accounts that were passed in argument
        List<Contact> contt = [SELECT AccountId,Id,KYC_Status__c FROM Contact WHERE Id IN : mapContact.keySet()];
        //map for populating values of kyc status from contact with respect to AccountId and ConatctId and status of kyc 
        Map<Id,Map<string,Integer>> mapIdMapContact = new Map<Id,Map<string,Integer>>();
        //loop for Iterate aggregate query in map
        for(Contact cc : contt){
            //valiable to store AccountId
            Id acId = (Id)cc.get('AccountId');
            //valiable to store ContactId
            Id cnnId = (Id)cc.get('Id');
            //valiable to store kyc_status from contact
            String stt = String.valueOf(cc.get('KYC_Status__c'));
            //populating the map
            if(!mapIdMapContact.containsKey(acId)){
                mapIdMapContact.put(acId, new Map<string,Integer>());
                mapIdMapContact.get(acId).put('Green',0);
                mapIdMapContact.get(acId).put('Yellow',0);
                mapIdMapContact.get(acId).put('Red',0);
            }

            if(stt == 'Green'){
                //con.KYC_Status__c = 'Green';
                mapIdMapContact.get(acId).put('Green', mapIdMapContact.get(acId).get('Green')+1);
            }
            if(stt == 'Red'){
                //con.KYC_Status__c= 'Red';
                mapIdMapContact.get(acId).put('Red', mapIdMapContact.get(acId).get('Red')+1);
            }
            if(stt == 'Yellow'){
                //con.KYC_Status__c = 'Yellow';
                mapIdMapContact.get(acId).put('Yellow', mapIdMapContact.get(acId).get('Yellow')+1);
            }
             
        }
        System.debug('------map-------'+ mapIdMapContact);
        //this Account list is to update the Account KYC status
        List<Account> ac = new List<Account>();
        //Iterating list with map key set.
        for(Id accc : mapIdMapContact.keySet()){
            Account act = new Account(Id=accc);
            //Following are the condition checks for flag updation
            if(mapIdMapContact.get(accc).get('Yellow') == 0 && mapIdMapContact.get(accc).get('Red') == 0){
                act.KYC_Status__c = 'Green';
            }
            if(mapIdMapContact.get(accc).get('Yellow') == 0 && mapIdMapContact.get(accc).get('Green') == 0){
                act.KYC_Status__c = 'Red';
            }
            if(mapIdMapContact.get(accc).get('Green') == 0 && mapIdMapContact.get(accc).get('Red') == 0){
                act.KYC_Status__c = 'Yellow';
            }
            if(mapIdMapContact.get(accc).get('Green') != 0 && mapIdMapContact.get(accc).get('Red') != 0){
                act.KYC_Status__c = 'Yellow';
            }
            if(mapIdMapContact.get(accc).get('Yellow') != 0 && mapIdMapContact.get(accc).get('Green') != 0){
                act.KYC_Status__c = 'Yellow';
            }
            if(mapIdMapContact.get(accc).get('Yellow') != 0 && mapIdMapContact.get(accc).get('Red') != 0){
                act.KYC_Status__c = 'Yellow';
            }
            if(mapIdMapContact.get(accc).get('Yellow') != 0 && mapIdMapContact.get(accc).get('Green') != 0 && mapIdMapContact.get(accc).get('Red') != 0){
                act.KYC_Status__c = 'Yellow';
            }
            if(mapIdMapContact.get(accc).get('Yellow') == 0 && mapIdMapContact.get(accc).get('Green') == 0 && mapIdMapContact.get(accc).get('Red') == 0){
                act.KYC_Status__c = '';
            }
            //adding the Account in list
            ac.add(act);
        }
        //printing the Contact lis
        System.debug(ac);
        ////updating the Accounts with there values of kyc status and flag
        update ac;
            
}
}
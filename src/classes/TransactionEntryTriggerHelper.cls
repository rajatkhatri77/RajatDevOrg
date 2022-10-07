/**
*  Description     :  This is Transaction Entry Trigger handler Class
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  04/14/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
public with sharing class TransactionEntryTriggerHelper {
    /**
    * 
    *   @description    :   In this method we are chacking the Maximum Number of transaction for Particular Contact
    *
    *   @args           :   List of Transaction_Entry__c
    *
    *   @return         :   
    *
    *   @revision Log   :   V1.1 - Created  - 04/14/2021 - Rajat khatri
    * 
    **/
    public static void validationOnTransactionEntries(List<Transaction_Entry__c> newTxEntries){
        Map<Id,List<Transaction_Entry__c>> mapOfcontactIdsWithTxEntries = new Map<Id,List<Transaction_Entry__c>>();
        //storing the Contact id of TXEntry with list of transaction entries associated with it contact id
        for(Transaction_Entry__c txEntries : newTxEntries){
            if(!mapOfcontactIdsWithTxEntries.containsKey(txEntries.Contact__c)){
                mapOfcontactIdsWithTxEntries.put(txEntries.Contact__c, new List<Transaction_Entry__c>());
            }
                mapOfcontactIdsWithTxEntries.get(txEntries.Contact__c).add(txEntries);
        }
        //checking the size of map
        if(mapOfcontactIdsWithTxEntries.size() > 0){
            //stroring the Contact id with contact
            Map<Id,Contact> mapContactIdWithContact = new Map<Id,Contact>();
            //populating map with ids and contacts
            for(Contact con :[SELECT Id, Transaction_Limit__r.Maximum_Transactions_Allowed_per_Day__c, Transaction_Limit__r.Maximum_Transactions_Allowed_per_Month__c, Transaction_Limit__r.Maximum_Debit_Allowed_per_Day__c, Transaction_Limit__r.Maximum_Debit_Allowed_per_Month__c FROM Contact WHERE Id IN:mapOfcontactIdsWithTxEntries.keySet()]){
                if(!mapCOntactIdWithContact.containsKey(con.Id)){
                    mapCOntactIdWithContact.put(con.Id, con);
                }
            }
            //storing Contact id with String of count of TxEntries and total Debit amount for today
            Map<Id,String> mapOfContactIdWithTodayTxEntriesCount = new Map<Id,String>();
            //applying Aggregate query and populating the map
            for(AggregateResult ar : [SELECT COUNT(Id) totalTxEntry, SUM(Amount__c) amount,Contact__c,Type__c FROM Transaction_Entry__c WHERE Transaction_Date__c = TODAY AND Contact__c IN:mapContactIdWithContact.keySet() Group By Type__c,Contact__c]){
                if(!mapOfContactIdWithTodayTxEntriesCount.containsKey((Id)ar.get('Contact__c'))){
                    mapOfContactIdWithTodayTxEntriesCount.put((Id)ar.get('Contact__c'), String.valueOf(ar.get('totalTxEntry')) + ',' + String.valueOf((ar.get('Type__c') == 'Debit' ? (Double)ar.get('amount') : 0)));
                }
                else{
                    Integer todayTxEntries = Integer.valueOf(mapOfContactIdWithTodayTxEntriesCount.get((Id)ar.get('Contact__c')).split( ',' )[0]) + (Integer)ar.get('totalTxEntry');
                    Double todayDebitAmount = Double.valueOf(mapOfContactIdWithTodayTxEntriesCount.get((Id)ar.get('Contact__c')).split( ',' )[1]) + (ar.get('Type__c') == 'Debit' ? (Double)ar.get('amount') : 0);
                    mapOfContactIdWithTodayTxEntriesCount.put((Id)ar.get('Contact__c'), todayTxEntries + ',' + todayDebitAmount);
                }
            }
            System.debug('today: ' + mapOfContactIdWithTodayTxEntriesCount);
            //storing Contact id with String of count of TxEntries and total Debit amount for today
            Map<Id,String> mapOfContactIdWithMonthTxEntriesCount = new Map<Id,String>();
            //applying Aggregate query and populating the map
            for(AggregateResult ar : [SELECT COUNT(Id) totalTxEntry, SUM(Amount__c) amount,Contact__c,Type__c FROM Transaction_Entry__c WHERE CALENDAR_MONTH(Transaction_Date__c) =:(Integer)System.Today().Month() AND CALENDAR_YEAR(Transaction_Date__c) =:(Integer)System.Today().Year() AND Contact__c IN:mapContactIdWithContact.keySet() Group By Type__c,Contact__c]){
                if(!mapOfContactIdWithMonthTxEntriesCount.containsKey((Id)ar.get('Contact__c'))){
                    mapOfContactIdWithMonthTxEntriesCount.put((Id)ar.get('Contact__c'), String.valueOf(ar.get('totalTxEntry')) + ',' + String.valueOf((ar.get('Type__c') == 'Debit' ? (Double)ar.get('amount') : 0)));
                }
                else{
                    Integer monthTxEntries = Integer.valueOf(mapOfContactIdWithMonthTxEntriesCount.get((Id)ar.get('Contact__c')).split( ',' )[0]) + (Integer)ar.get('totalTxEntry');
                    Double monthDebitAmount = Double.valueOf(mapOfContactIdWithMonthTxEntriesCount.get((Id)ar.get('Contact__c')).split( ',' )[1]) + (ar.get('Type__c') == 'Debit' ? (Double)ar.get('amount') : 0);
                    mapOfContactIdWithMonthTxEntriesCount.put((Id)ar.get('Contact__c'), monthTxEntries + ',' + monthDebitAmount);
                }
            }
            System.debug('This Month: ' + mapOfContactIdWithMonthTxEntriesCount);
            for(Id conId : mapOfcontactIdsWithTxEntries.keySet()){
                for(Transaction_Entry__c txEntry : mapOfcontactIdsWithTxEntries.get(conId)){
                    if(mapOfContactIdWithTodayTxEntriesCount.get(txEntry.Contact__c) != null){
                        //isNotBlank(String.valueOf(mapOfContactIdWithTodayTxEntriesCount.get(txEntry.Contact__c)))
                        //checking the today transaction limits
                        if(Integer.valueOf(mapOfContactIdWithTodayTxEntriesCount.get(txEntry.Contact__c).split( ',' )[0]) >= mapContactIdWithContact.get(txEntry.Contact__c).Transaction_Limit__r.Maximum_Transactions_Allowed_per_Day__c){
                        	txEntry.addError('You can not credit/debit from your account, your today'+'\''+'s limit is exceeded.');
                    	}
                        //checking the today debit amount limit
                    	if(Integer.valueOf(mapOfContactIdWithTodayTxEntriesCount.get(txEntry.Contact__c).split( ',' )[1]) >= mapContactIdWithContact.get(txEntry.Contact__c).Transaction_Limit__r.Maximum_Debit_Allowed_per_Day__c){
                        	txEntry.addError('Amount from your account can not be debited, your Amount Debit Limit for today' +'\''+'s is exceeded.');
                    	}
                    }
                    if(mapOfContactIdWithMonthTxEntriesCount.get(txEntry.Contact__c) != null){
                        if(Integer.valueOf(mapOfContactIdWithMonthTxEntriesCount.get(txEntry.Contact__c).split( ',' )[0]) >= mapContactIdWithContact.get(txEntry.Contact__c).Transaction_Limit__r.Maximum_Transactions_Allowed_per_Month__c){
                        	txEntry.addError('You can not credit/debit from your account, your Month'+'\''+'s limit is exceeded.');
                    	}
                    	if(Integer.valueOf(mapOfContactIdWithMonthTxEntriesCount.get(txEntry.Contact__c).split( ',' )[1]) >= mapContactIdWithContact.get(txEntry.Contact__c).Transaction_Limit__r.Maximum_Debit_Allowed_per_Month__c){
                        	txEntry.addError('Amount from your account can not be debited, your Amount Debit Limit for Month' +'\''+'s is exceeded.');
                    	}
                    }  
                }
            }			
        }
    }
 }
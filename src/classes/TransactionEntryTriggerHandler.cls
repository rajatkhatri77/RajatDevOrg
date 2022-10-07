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
public with sharing class TransactionEntryTriggerHandler {
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
    /*public static void checkTransactionLimit(List<Transaction_Entry__c> transactinEntryList){
            //set of contct id which are associted with entries passed in agrumnet list 
            Set<Id> setOfContactId = new Set<Id>();
            //itrating loop over the  passed  Argument Transaction entry list
            for(Transaction_Entry__c tranEntry : transactinEntryList){
                    setOfContactId.add(tranEntry.Contact__c);
            }


            
            //map to store the contact id with todays entries
            Map<Id,List<Transaction_Entry__c>> mapContactIdWithTransactionEntriesOfToday = new Map<Id,List<Transaction_Entry__c>>();
                //Fetching transaction entries of taday
                List<Transaction_Entry__c> tEntyOfToday=[SELECT Id,Contact__c FROM Transaction_Entry__c WHERE Contact__c IN:setOfContactId AND Transaction_Date__c = TODAY];
                if(tEntyOfToday.size() > 0){
                    //populating the map with transaction entries list and Associated Contact
                    for(Transaction_Entry__c tEntry : tEntyOfToday){
                        //checking this contact is present in map or not
                        if(!mapContactIdWithTransactionEntriesOfToday.containsKey(tEntry.Contact__c)){
                            //Add contct id im map initilize the list
                            mapContactIdWithTransactionEntriesOfToday.put(tEntry.Contact__c, new List<Transaction_Entry__c>());
                        }
                        //adding the transaction entry in map to corresponding contact id
                        mapContactIdWithTransactionEntriesOfToday.get(tEntry.Contact__c).add(tEntry);
                    }
                }
            }
            
            //to get this month
            Integer currentMonth = System.today().MOnth();
            //to get year
            Integer currentYear = System.today().Year();
            //map to store the contact id with this month entries
            Map<Id,List<Transaction_Entry__c>> mapContactIdWithTransactionEntriesOfThisMonth = new Map<Id,List<Transaction_Entry__c>>();
            if(setOfContactId.size() > 0){
                //fetching the transaction entries of this month
                List<Transaction_Entry__c> tEntryOfThisMonth = [SELECT Id,Contact__c,Transaction_Date__c FROM Transaction_Entry__c WHERE Contact__c IN:setOfContactId AND CALENDAR_MONTH(Transaction_Date__c) = :currentMonth and CALENDAR_YEAR(Transaction_Date__c) = :currentYear];
                if(tEntryOfThisMonth.size() > 0){
                    //populating the map with transaction entries list and Associated Contact
                    for(Transaction_Entry__c tEntry : tEntryOfThisMonth){
                        if(!mapContactIdWithTransactionEntriesOfThisMonth.containsKey(tEntry.Contact__c)){
                            mapContactIdWithTransactionEntriesOfThisMonth.put(tEntry.Contact__c, new List<Transaction_Entry__c>());
                        }
                        mapContactIdWithTransactionEntriesOfThisMonth.get(tEntry.Contact__c).add(tEntry);
                    }
                }  
            }
           
            
            Map<Id,String> mapContactIdWithTransactionLimitId = new Map<Id,String>();
            if(setOfContactId.size() > 0){
                //ittrating on soql to populating the map
                for(Contact con : [SELECT Transaction_Limit__c,Id FROM Contact WHERE Id IN:setOfContactId]){
                    //converting the Transaction_Limit id from object to string
                    String tranLimit = String.valueOf(con.Transaction_Limit__c);
                    //populating in map contact id with corresponding transction limit id
                    mapContactIdWithTransactionLimitId.put(con.Id, tranLimit);
                }
            }
            

             //map of Transaction limit id with map of String with integer to store the max Limit allow perday and max limit allow in month
            Map<Id,Map<String,Integer>> mapTransactionLimitIdWithDayAndMonth = new Map<Id,Map<String,Integer>>();
            //itrating on soql to populate map
            for(Transaction_Limit__c trnLimit : [SELECT Id,Maximum_Transactions_Allowed_per_Day__c,Maximum_Transactions_Allowed_per_Month__c FROM Transaction_Limit__c]){
                //taking per day limit in integet variable
                Integer perDay = (Integer)trnLimit.Maximum_Transactions_Allowed_per_Day__c;
                //taking per month limit in integet variable
                Integer perMonth = (Integer)trnLimit.Maximum_Transactions_Allowed_per_Month__c;
                //populating map 
                if(!mapTransactionLimitIdWithDayAndMonth.containsKey(trnLimit.Id)){
                    mapTransactionLimitIdWithDayAndMonth.put(trnLimit.Id, new Map<String,Integer>());
                    mapTransactionLimitIdWithDayAndMonth.get(trnLimit.Id).put('perDayLimit', perDay);
                    mapTransactionLimitIdWithDayAndMonth.get(trnLimit.Id).put('perMonthLimit', perMonth);
                }
            }


            // System.debug('############################');
            // for(Id t : mapTransactionLimitIdWithDayAndMonth.keySet()){
            //     System.debug(mapTransactionLimitIdWithDayAndMonth.get(t));
            // }
            // System.debug('############################');


            //this to store the Count of entries in today
            Integer countOfTranEntryToday;
            //this to store the count of entries in this month
            Integer countOfTranEntryThisMonth;
            //itrating on the passed list in argument
            for(Transaction_Entry__c transactionEntry : transactinEntryList){
                //getting the id of contact associted with entry
                Id tranEntryContactId = transactionEntry.Contact__c;
                //geting the list of today entry associted with contact
                List<Transaction_Entry__c> listOfTranEntryToday = mapContactIdWithTransactionEntriesOfToday.get(tranEntryContactId);
                System.debug('listOfTranEntryToday: ' + listOfTranEntryToday);
                //checking is its not null
                if(ListOfTranEntryToday != null){
                    //storing the size in variable
                    
                    countOfTranEntryToday = listOfTranEntryToday.size();
                }
                //if list is null then we are giving zero to the variable
                else{
                    countOfTranEntryToday = 0;
                }
                System.debug('countOfTranEntryToday: ' + countOfTranEntryToday);
                //geting the list of months entry associted with contact
                List<Transaction_Entry__c> listOfTranEntryThisMonth = mapContactIdWithTransactionEntriesOfThisMonth.get(tranEntryContactId);
                System.debug('listOfTranEntryThisMonth: ' + listOfTranEntryThisMonth);
                //checking is its not null
                if(ListOfTranEntryThisMonth != null){
                    //storing the size in variable
                    countOfTranEntryThisMonth = listOfTranEntryThisMonth.size();
                }
                //if list is null then we are giving zero to the variable
                else{
                    countOfTranEntryThisMonth = 0;
                }
                System.debug('countOfTranEntryThisMonth: ' + countOfTranEntryThisMonth);
                //getting the Id of transaction id Associted with Contact
                String transactionLimitId = mapContactIdWithTransactionLimitId.get(tranEntryContactId);
                System.debug('');

                //geting the max transactin limit allow per day from transaction limit
                Integer maxLimitPerDay = mapTransactionLimitIdWithDayAndMonth.get(transactionLimitId).get('perDayLimit');
                System.debug('maxLimitPerDay: ' + maxLimitPerDay);
                //geting the max transactin limit allow per month from transaction limit
                Integer maxLimitPerMonth = mapTransactionLimitIdWithDayAndMonth.get(transactionLimitId).get('perMonthLimit');
                System.debug('maxLimitPerMonth: ' + maxLimitPerMonth);

                //checking if the count of transaction entries per day is equal or greater then it will not allow to Create Transaction entry for the day
                if(countOfTranEntryToday >= maxLimitPerDay){
                    //Adding error
                    transactionEntry.addError('You can not credit/debit from your account, your today'+'\''+'s limit is exceeded.');
                    System.debug('This will give error because of Transaction limit exceed for day');  
                }

                //checking if the count of transaction entries for this month is equal or greater then it will not allow to Create Transaction entry for this month
                if(countOfTranEntryThisMonth >= maxLimitPerMonth){
                    //Adding error
                        transactionEntry.addError('You can not credit/debit from your account, your this month'+'\''+'s limit is exceeded.');
                        System.debug('This will give error because of Transaction limit exceed for month');
                }
            }
        
    }*/

    /**
    * 
    *   @description    :   In this method we are chacking the Maximum Amount can be debited from Particular Contact
    *
    *   @args           :   List of Transaction_Entry__c
    *
    *   @return         :   
    *
    *   @revision Log   :   V1.1 - Created  - 04/16/2021 - Rajat khatri
    * 
    **/
    /*public static void checkingDebitAmountLimit(List<Transaction_Entry__c> transactinEntryList){
        if(transactinEntryList.size() > 0){
            //set of contct id
            Set<Id> setOfContactId = new Set<Id>();
            //itrating loop over Transaction entry list
            for(Transaction_Entry__c tranEntry : transactinEntryList){
                //if the Entry is of Debit type
                if(tranEntry.Type__c == 'Debit'){
                    //adding the contact id Associated with that Entry in set
                    setOfContactId.add(tranEntry.Contact__c);
                }
            }

        
            //todays date
            Date todayDate = System.today();
            //map to store the Contact id with total Amount debited today
            Map<Id,Integer> mapContactIdWithAmountDeditedToday = new Map<Id,Integer>();
            if(setOfContactId.size() > 0){
                   //itrating over applyed soql and populating the map
                    for(Transaction_Entry__c tEntry : [SELECT Id,Contact__c,Amount__c FROM Transaction_Entry__c WHERE Contact__c =:setOfContactId AND Transaction_Date__c =:todayDate AND Type__c ='Debit']){
                        //amount debited stored in variable 
                        Integer amount = (Integer)tEntry.Amount__c;
                        //checking the if map have this key
                        if(!mapContactIdWithAmountDeditedToday.containsKey(tEntry.Contact__c)){
                            //initilizing the key in map
                            mapContactIdWithAmountDeditedToday.put(tEntry.Contact__c,0);
                        }
                        //Adding the amount correspondin the Contact id
                        mapContactIdWithAmountDeditedToday.put(tEntry.Contact__c,(mapContactIdWithAmountDeditedToday.get(tEntry.Contact__c) + amount));
                    }
                }
            System.debug('mapContactIdWithAmountDeditedToday: ' + mapContactIdWithAmountDeditedToday);


            //to get this month
            Integer currentMonth = System.today().MOnth();
            //to get this year
            Integer currentYear = System.today().Year();
            //map to store the Contact id with total Amount debited this month
            Map<Id,Integer> mapContactIdWithAmountDeditedThisMonth = new Map<Id,Integer>();
            if(setOfContactId.size() > 0){
                //itrating over applyed soql and populating the map
                for(Transaction_Entry__c trnEntry : [SELECT Id,Contact__c,Transaction_Date__c,Amount__c FROM Transaction_Entry__c WHERE Contact__c =:setOfContactId AND Type__c ='Debit' AND CALENDAR_MONTH(Transaction_Date__c) = :currentMonth and CALENDAR_YEAR(Transaction_Date__c) = :currentYear]){
                    //amount debited stored in variable
                    Integer amountt = (Integer)trnEntry.Amount__c;
                    if(!mapContactIdWithAmountDeditedThisMonth.containsKey(trnEntry.Contact__c)){
                        mapContactIdWithAmountDeditedThisMonth.put(trnEntry.Contact__c,0);
                    }
                    mapContactIdWithAmountDeditedThisMonth.put(trnEntry.Contact__c,(mapContactIdWithAmountDeditedThisMonth.get(trnEntry.Contact__c)+ amountt));
                }
            }
            System.debug('mapContactIdWithAmountDeditedThisMonth: ' + mapContactIdWithAmountDeditedThisMonth);

            //map to store the Contact id With Transaction Limit Id
            Map<Id,String> mapContactIdWIthTransactionLimitId = new Map<Id,String>();
            if(setOfContactId.size() > 0){
                //ittrating on soql to populating the map
                for(Contact con : [SELECT Transaction_Limit__c,Id FROM Contact WHERE Id =:setOfContactId]){
                    //converting the Transaction_Limit id in String
                    String tranLimit = String.valueOf(con.Transaction_Limit__c);
                    mapContactIdWIthTransactionLimitId.put(con.Id, tranLimit);
                }
            }
            

            //map to store the max Limit allow perday and max limit allow in month
            Map<Id,Map<String,Integer>> mapMaxDebitAmountLimitWithDayAndMonth = new Map<Id,Map<String,Integer>>();
            //itrating on soql to populate map
            for(Transaction_Limit__c trnLimit : [SELECT Id,Maximum_Debit_Allowed_per_Day__c,Maximum_Debit_Allowed_per_Month__c FROM Transaction_Limit__c]){
                //taking per day limit in integet variable
                Integer perDay = (Integer)trnLimit.Maximum_Debit_Allowed_per_Day__c;
                //taking per month limit in integet variable
                Integer perMonth = (Integer)trnLimit.Maximum_Debit_Allowed_per_Month__c;
                if(!mapMaxDebitAmountLimitWithDayAndMonth.containsKey(trnLimit.Id)){
                    mapMaxDebitAmountLimitWithDayAndMonth.put(trnLimit.Id, new Map<String,Integer>());
                    mapMaxDebitAmountLimitWithDayAndMonth.get(trnLimit.Id).put('perDayLimit', perDay);
                    mapMaxDebitAmountLimitWithDayAndMonth.get(trnLimit.Id).put('perMonthLimit', perMonth);
                }
            }


            //itrating on the passed list in argument
            for(Transaction_Entry__c transactionEntry : transactinEntryList){
                //checking if the ENtry is of Debit or not
                if(transactionEntry.Type__c == 'Debit'){
                    //storing the Contact id in variable to get related details.
                    Id tranEntryContactId = transactionEntry.Contact__c;
                    //Getting the total AMount debited today form map
                    Integer totalDebitAmountToday = mapContactIdWithAmountDeditedToday.get(tranEntryContactId);
                    System.debug('totalDebitAmountToday: ' + totalDebitAmountToday);
                    //Getting the total AMount debited this month form map
                    Integer totalDebitAmountThisMonth = mapContactIdWithAmountDeditedThisMonth.get(tranEntryContactId);
                    System.debug('totalDebitAmountThisMonth: ' + totalDebitAmountThisMonth);

                    //getting the Transaction limit id associated with contact
                    String transactionLimitId = mapContactIdWIthTransactionLimitId.get(tranEntryContactId);

                    //getting the Maximum Debit Amount per day Limit form transaction limit
                    Integer maxDebitLimitPerDay = mapMaxDebitAmountLimitWithDayAndMonth.get(transactionLimitId).get('perDayLimit');
                    System.debug('maxDebitLimitPerDay: ' + maxDebitLimitPerDay);
                    //getting the Maximum Debit Amount per month Limit form transaction limit
                    Integer maxDebitLimitPerMonth = mapMaxDebitAmountLimitWithDayAndMonth.get(transactionLimitId).get('perMonthLimit');
                    System.debug('maxDebitLimitPerMonth: ' + maxDebitLimitPerMonth);

                    //checking the if total debit amount today is greater then max limit or not
                    if(totalDebitAmountToday >= maxDebitLimitPerDay){
                        transactionEntry.addError('Amount from your account can not be debited, your Amount Debit Limit for today' +'\''+'s is exceeded.');
                        System.debug('Amount from your account can not be debited, your Amount Debit Limit for today is exceeded.');
                    }

                    //checking the if total debit amount this month is greater then max limit or not
                    if(totalDebitAmountThisMonth >= maxDebitLimitPerMonth){
                        transactionEntry.addError('Amount from your account can not be debited, your Amount Debit Limit for this month' +'\''+'s is exceeded.');
                        System.debug('Amount from your account can not be debited, your Amount Debit Limit for this month is exceeded.');
                    }
                }
            }
        }
    }*/
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
    public static void checkTransactionLimit(List<Transaction_Entry__c> newTxEntries){
        //set of Id
        Set<Id> contactIds = new Set<Id>();
        for(Transaction_Entry__c txEntry : newTxEntries){
            //adding the Contact id in set
            contactIds.add(txEntry.Contact__c);
        }

        //checking the size set of ids
        if(contactIds.size() > 0){
            //map of contact id with count of Transaction entries and amount debited per day
            Map<Id,Map<String,Integer>> mapOfContactIdWithCountTxEntriesAndDebitAmountForPerDay = new Map<Id,Map<String,Integer>>();
            for(Transaction_Entry__c txEntry : [SELECT Id,Contact__c,Type__c,Amount__c,Transaction_Date__c FROM Transaction_Entry__c WHERE Contact__c IN:contactIds AND Transaction_Date__c = TODAY]){
                if(!mapOfContactIdWithCountTxEntriesAndDebitAmountForPerDay.containsKey(txEntry.Contact__c)){
                    mapOfContactIdWithCountTxEntriesAndDebitAmountForPerDay.put(txEntry.Contact__c, new Map<String,Integer>());
                    mapOfContactIdWithCountTxEntriesAndDebitAmountForPerDay.get(txEntry.Contact__c).put('countOfTxEntries',0);
                    mapOfContactIdWithCountTxEntriesAndDebitAmountForPerDay.get(txEntry.Contact__c).put('amountDebited',0);
                }
                mapOfContactIdWithCountTxEntriesAndDebitAmountForPerDay.get(txEntry.Contact__c).put('countOfTxEntries', (Integer)mapOfContactIdWithCountTxEntriesAndDebitAmountForPerDay.get(txEntry.Contact__c).get('countOfTxEntries') + 1);
                if(txEntry.Type__c == 'Debit'){
                    mapOfContactIdWithCountTxEntriesAndDebitAmountForPerDay.get(txEntry.Contact__c).put('amountDebited', mapOfContactIdWithCountTxEntriesAndDebitAmountForPerDay.get(txEntry.Contact__c).get('amountDebited') + (Integer)txEntry.Amount__c);
                }
            }
            System.debug('per Day: ' + mapOfContactIdWithCountTxEntriesAndDebitAmountForPerDay);

            //map of contact id with count of Transaction entries and amount debited per month
            Map<Id,Map<String,Integer>> mapOfContactIdWithCountTxEntriesAndDebitAmountForPerMonth = new Map<Id,Map<String,Integer>>();
            for(Transaction_Entry__c txEntry : [SELECT Id,Contact__c,Type__c,Amount__c,Transaction_Date__c FROM Transaction_Entry__c WHERE CALENDAR_MONTH(Transaction_Date__c) =:(Integer)System.Today().Month() AND CALENDAR_YEAR(Transaction_Date__c) =:(Integer)System.Today().Year() AND  Contact__c IN:contactIds]){
                if(!mapOfContactIdWithCountTxEntriesAndDebitAmountForPerMonth.containsKey(txEntry.Contact__c)){
                    mapOfContactIdWithCountTxEntriesAndDebitAmountForPerMonth.put(txEntry.Contact__c, new Map<String,Integer>());
                    mapOfContactIdWithCountTxEntriesAndDebitAmountForPerMonth.get(txEntry.Contact__c).put('countOfTxEntries',0);
                    mapOfContactIdWithCountTxEntriesAndDebitAmountForPerMonth.get(txEntry.Contact__c).put('amountDebited',0);
                }
                mapOfContactIdWithCountTxEntriesAndDebitAmountForPerMonth.get(txEntry.Contact__c).put('countOfTxEntries', (Integer)mapOfContactIdWithCountTxEntriesAndDebitAmountForPerMonth.get(txEntry.Contact__c).get('countOfTxEntries') + 1);
                if(txEntry.Type__c == 'Debit'){
                    mapOfContactIdWithCountTxEntriesAndDebitAmountForPerMonth.get(txEntry.Contact__c).put('amountDebited', mapOfContactIdWithCountTxEntriesAndDebitAmountForPerMonth.get(txEntry.Contact__c).get('amountDebited') + (Integer)txEntry.Amount__c);
                }
            }
            System.debug('per Month: ' + mapOfContactIdWithCountTxEntriesAndDebitAmountForPerMonth);

            //map of contact id with the transaction limits
            Map<Id,Map<String,Integer>> mapOfContactIdWithTxLimits = new Map<Id,Map<String,Integer>>();
            for(Contact con :[SELECT Id, Transaction_Limit__r.Maximum_Transactions_Allowed_per_Day__c, Transaction_Limit__r.Maximum_Transactions_Allowed_per_Month__c, Transaction_Limit__r.Maximum_Debit_Allowed_per_Day__c, Transaction_Limit__r.Maximum_Debit_Allowed_per_Month__c FROM Contact WHERE Id IN:contactIds]){
                if(!mapOfContactIdWithTxLimits.containsKey(con.Id)){
                    mapOfContactIdWithTxLimits.put(con.Id, new Map<String,Integer>());
                }
                mapOfContactIdWithTxLimits.get(con.Id).put('txAllowedPerDay',(Integer)con.Transaction_Limit__r.Maximum_Transactions_Allowed_per_Day__c);
                mapOfContactIdWithTxLimits.get(con.Id).put('txAllowedPerMonth',(Integer)con.Transaction_Limit__r.Maximum_Transactions_Allowed_per_Month__c);
                mapOfContactIdWithTxLimits.get(con.Id).put('maxDebitAllowedPerDay',(Integer)con.Transaction_Limit__r.Maximum_Debit_Allowed_per_Day__c);
                mapOfContactIdWithTxLimits.get(con.Id).put('maxDebitAllowedPerMonth',(Integer)con.Transaction_Limit__r.Maximum_Debit_Allowed_per_Month__c);
            }
            System.debug('Transaction Limits: ' + mapOfContactIdWithTxLimits);
            //checking the limitsof transaction entries
            for(Transaction_Entry__c txEntry : newTxEntries){
                if(mapOfContactIdWithCountTxEntriesAndDebitAmountForPerDay.get(txEntry.Contact__c) != null){
                     if(mapOfContactIdWithCountTxEntriesAndDebitAmountForPerDay.get(txEntry.Contact__c).get('countOfTxEntries') >= mapOfContactIdWithTxLimits.get(txEntry.Contact__c).get('txAllowedPerDay')){
                        txEntry.addError('You can not credit/debit from your account, your today'+'\''+'s limit is exceeded.');
                    }
                    if(mapOfContactIdWithCountTxEntriesAndDebitAmountForPerDay.get(txEntry.Contact__c).get('amountDebited') >= mapOfContactIdWithTxLimits.get(txEntry.Contact__c).get('maxDebitAllowedPerDay')){
                        txEntry.addError('Amount from your account can not be debited, your Amount Debit Limit for today' +'\''+'s is exceeded.');
                    }
                }
                if(mapOfContactIdWithCountTxEntriesAndDebitAmountForPerMonth.get(txEntry.Contact__c) != null){
                    if(mapOfContactIdWithCountTxEntriesAndDebitAmountForPerMonth.get(txEntry.Contact__c).get('countOfTxEntries') >= mapOfContactIdWithTxLimits.get(txEntry.Contact__c).get('txAllowedPerMonth')){
                        txEntry.addError('You can not credit/debit from your account, your this month'+'\''+'s limit is exceeded.');
                    }
                    if(mapOfContactIdWithCountTxEntriesAndDebitAmountForPerMonth.get(txEntry.Contact__c).get('amountDebited') >= mapOfContactIdWithTxLimits.get(txEntry.Contact__c).get('maxDebitAllowedPerMonth')){
                        txEntry.addError('Amount from your account can not be debited, your Amount Debit Limit for this month is exceeded.');
                    }
                }
            }
        }
    }
}
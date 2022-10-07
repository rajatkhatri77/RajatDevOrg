/**
*  Description     :  This is Assignment 5 apex class and in this we will using Aggregate query and finding the status of task and updating it to fields in accounts.
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  01/16/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
public with sharing class Assignment5 {
    /**
    * 
    *   @description    :   In this method we are taking account List and Due date of the tasks getting the count of status and in map and using the Account list to update it on Accounts fields.
    *
    *   @args           :   List of Account and Due date.
    *
    *   @return         :   
    *
    *   @revision Log   :   V1.1 - Created  - 01/16/2021 - Rajat khatri
    * 
    **/
    public static void rollupinfo(List<Account> accounts, Date due){
        //This is Aggregate Result List on which we have applied the Aggregate query.
        AggregateResult[] accountAgg = [SELECT AccountId,Status,COUNT(Id) FROM Task WHERE ActivityDate <= : due GROUP BY AccountId,Status];
        //This is the map in which we are storing Aggregate query in structured format and associating it with Account ID.
        Map<Id,Map<String,Integer>> MapWithIdAndMap = new Map<Id,Map<String,Integer>>();
        //Loop on Aggregate query to Iterate in map
        for(AggregateResult agg : accountAgg){
            if(!MapWithIdAndMap.containskey(agg.Id)){
                MapWithIdAndMap.put((Id)agg.get('AccountId'),new Map<String,Integer>());
                MapWithIdAndMap.get((Id)agg.get('AccountId')).put('Open Task',0);
                MapWithIdAndMap.get((Id)agg.get('AccountId')).put('Complete Task', 0);
            }
            //For chacking and updating the complete task.
            if(agg.get('Status') == 'Completed'){
                MapWithIdAndMap.get((Id)agg.get('AccountId')).put('Complete Task',MapWithIdAndMap.get((Id)agg.get('AccountId')).get('Complete Task')+1);
            } 
            //For chacking and updating the open task with status Not started.
            if(agg.get('Status') == 'Not Started'){
                MapWithIdAndMap.get((Id)agg.get('AccountId')).put('Open Task',MapWithIdAndMap.get((Id)agg.get('AccountId')).get('Open Task')+1);
            }
            //For chacking and updating the open task with status In Progress.
            if(agg.get('Status') == 'In Progress'){
                MapWithIdAndMap.get((Id)agg.get('AccountId')).put('Open Task',MapWithIdAndMap.get((Id)agg.get('AccountId')).get('Open Task')+1);
            }
            //For chacking and updating the open task with statusWaiting on someone else.
            if(agg.get('Status') == 'Waiting on someone else'){
                MapWithIdAndMap.get((Id)agg.get('AccountId')).put('Open Task',MapWithIdAndMap.get((Id)agg.get('AccountId')).get('Open Task')+1);
            }    
        }
        //To print map satatus.
        System.debug(MapWithIdAndMap);
        //Account list to update it Accounts.
        List<Account> acc = new List<Account>();
        //Iterating list with map key set.
        for(Id accid : MapWithIdAndMap.keySet()){
            acc.add(new Account(Id=accid,Completed_Task__c = MapWithIdAndMap.get(accid).get('Complete Task'),
            Open_Task__c = MapWithIdAndMap.get(accid).get('Open Task'),
            Total_Task__c = MapWithIdAndMap.get(accid).get('Complete Task') + MapWithIdAndMap.get(accid).get('Open Task')));
        }
        //printing the list which we want to update.
        System.debug(acc); 
        //We have updated the Account fields.
        update acc;
}
}
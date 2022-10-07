trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    List<Task> taskList = new List<task>();
    for(Opportunity op : Trigger.New){
        if(op.StageName == 'Closed Won'){
            taskList.add(new Task(Subject = 'Follow up Test Task', WhatId = op.Id));
        }
    }
    if(taskList.size() > 0){
        insert taskList;
    }

}
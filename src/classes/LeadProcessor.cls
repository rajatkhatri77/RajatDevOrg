global class LeadProcessor implements Database.Batchable<sObject>{
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT ID FROM Lead');
    }
    global void execute (Database.BatchableContext bc, List<Lead> scope){
        List<Lead> lead = new List<Lead>();
        for(Lead leads : scope){
            leads.LeadSource = 'Dreamforce';
            lead.add(leads);
        }
        update lead;
    }
    global void finish(Database.BatchableContext bc){
        
    }

}
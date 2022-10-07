/**
*  Description     :  This Batch is for Sending Monthly emails to contacts to inform them about their this month's transactions.
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  04/18/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
global class BatchForMonthlyMail implements Schedulable,Database.Batchable<SObject>{
    global Database.QueryLocator start(Database.BatchableContext bc){
        // get active contacts whose email is not blank
        return Database.getQueryLocator('SELECT Id,Email,Account_Number__c,Available_Balance__c,Name FROM Contact WHERE' +
                                        ' Status__c = \'Active\' AND Email != null');
    }
    global void execute(Database.BatchableContext bc, List<Contact> contacts){
        
        //checking the size of contact list
        if(contacts.size()>0){
            //map to store the contact id with List of transaction entries retalted to that Contact Id
            Map<Id,List<Transaction_Entry__c>> mapContactIdWithTransactionEntries = new Map<Id,List<Transaction_Entry__c>>();
            //fetching the all the transaction entries related to activeContact
                for(Transaction_Entry__c tranEntry :[SELECT Amount__c,Type__c,Transaction_Date__c,Contact__c FROM Transaction_Entry__c WHERE 
                                                     Contact__c IN :contacts AND CALENDAR_MONTH(Transaction_Date__c) = :System.today().Month()
                                                     and CALENDAR_YEAR(Transaction_Date__c) = :System.today().Year() ORDER BY Transaction_Date__c DESC]){
                    System.debug('Transaction Entry: ' + tranEntry);
                    //checking if map have key or not
                    if(!mapContactIdWithTransactionEntries.containsKey(tranEntry.Contact__c)){
                        //adding key and initilizing the List of transaction Entry
                        mapContactIdWithTransactionEntries.put(tranEntry.Contact__c, new List<Transaction_Entry__c>());
                    }
                    //adding the transaction entry to list corrosponding to cotact id
                    mapContactIdWithTransactionEntries.get(tranEntry.Contact__c).add(tranEntry);
                }
            
            
            //list of Messaging.SingleEmailMessage
            List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMEssage>();
            //itrating on activeContacts List
            for(Contact cont : contacts){
                //initilizing the Messaging.SingleEmailMessage for each contact
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                //adding the email of contact in setToAddresses
                mail.setToAddresses(new String[]{cont.Email});
                //adding the Subject to email
                mail.setSubject('Your Account'+'\''+'s monthly Transactions');
                //string in which we are HTML templete of email is there
                String htmlbody = '<html><body><STYLE type="text/css">'
                    +'TH {font-size: 11px; font-face: arial;background: #CCCCCC;'
                    +'border-width: 1;  text-align: center }'
                    +'TD  {font-size: 11px; font-face: verdana }'
                    + 'TABLE {border: solid #CCCCCC; border-width: 1}'
                    + 'TR {border: solid #CCCCCC; border-width: 1}'
                    + '</STYLE>'
                    + '<font face="arial" size="2">'
                    + '<p>Dear '+ cont.Name + ',</p>'
                    +'<p>Your ' + cont.Account_Number__c + ' and your Available Balance is '+ cont.Available_Balance__c + ' </p>'
                    + '<p> Below is the list of Transaction related to your account</p>'
                    + '<table cellpadding="3" cellspacing="3" width="100%" align="center" border="1" style="border-collapse:collapse;">'
                    + '<tr style="font-weight:bold;">'
                    + '<th>Account number</th>'
                    + '<th>Debit/credit</th>'
                    + '<th>Amount</th>'
                    +'<th>Date</th>'
                    + '</tr>';
                //adding the transaction entries in table by itrating over the list of transaction entries in map associated with contact id
                if(mapContactIdWithTransactionEntries.get(cont.Id) !=null){
                    for(Transaction_Entry__c trnsEntry :mapContactIdWithTransactionEntries.get(cont.Id)){
                    	htmlbody += '<tr>'
                        	+ '<td>'+ cont.Account_Number__c + '</td>'
                        	+ '<td>' + trnsEntry.Type__c + '</td>'
                        	+ '<td>' + trnsEntry.Amount__c + '</td>'
                        	+ '<td>' + trnsEntry.Transaction_Date__c.format() + '</td>' + '</tr>';
                    	System.debug(htmlbody);
                    }
                }
                //after adding all transaction entries close table tag and all remaing tag
                htmlbody += '</table><p /></font></body></html>'; 
                //html body for contacts which have no tx entries
                String HTMLBodyWithNoTXEntries = '<html><body>'
                    + '<p>Dear '+ cont.Name + ',</p>'
                    +'<p>Your ' + cont.Account_Number__c + ' and your Available Balance is '+ cont.Available_Balance__c + ' </p>' + '<p>Thank you</p>' + '</body></html>';
                   
                //adding the string of htmlbody in Messaging.SingleEmailMessage setHTMLBody
                if(mapContactIdWithTransactionEntries.get(cont.Id) == null){
                    mail.setHTMLBody(HTMLBodyWithNoTXEntries);
                }
                if(mapContactIdWithTransactionEntries.get(cont.Id) != null){
                    mail.setHTMLBody(htmlbody);
                }
                System.debug(mail);
                //adding the single Messaging.SingleEmailMessage in list of Messaging.SingleEmailMessage
                mails.add(mail);
                System.debug('Email sample-> ' + mail);
                //checking if the size of Messaging.SingleEmailMessage list is greater then 0.
                if(mails.size() > 0){
                    //send mails 
                    //Messaging.sendEmail(mails);
                    
                } 
            }
        } 
    }
    global void finish(Database.BatchableContext BC){
        
    }
    global void execute(SchedulableContext ctx){
        Database.executeBatch(new BatchForMonthlyMail());        
    }
}
//
/**
*  Description     :  This is Contact trigger handler class.
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  02/09/2021
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
public without sharing class ContactTriggerHandler {
    /**
    * 
    *   @description    :   this method is for generating the QR Code for contact.
    *
    *   @args           :   List of Contact.
    *
    *   @return         :   
    *
    *   @revision Log   :   V1.1 - Created  - 04/29/2021 - Rajat khatri
    * 
    **/
    /*@future(callout=true)
    public static void qrCodeGenerator(String contactIds){
        //deserialize the argument in to list of contacts
        List<Contact> contactList = (List<Contact>) Json.deserialize(contactIds, List<Contact>.class);
        //list of attachment
        List<Attachment> attachmentList = new List<Attachment>();
        //itrating on list of contacts
        for(Contact con : contactList){
            //making the http callout
            Http http = new Http();
      		HttpRequest request = new HttpRequest();
            //seting the end point
        	request.setEndpoint('https://api.qrserver.com/v1/create-qr-code/?data='+ con.Id +'&size=220x220&margin=0');
        	request.setMethod('GET');
            request.setHeader('Content-Type', 'application/png');
        	HttpResponse response = http.send(request);
        	// If the request is successful, parse the JSON response.
            if (response.getStatusCode() == 200) {
                //storing the reponse in blob
                Blob img =  response.getBodyAsBlob();
                //adding the response in attachement
                Attachment attachment = new Attachment();
  				attachment.Body = img;
  				attachment.Name = 'QR Code';
  				attachment.ParentId = con.Id;
                attachment.contentType = 'image/png';
 				attachmentList.add(attachment);
            }
        }
        //checking the size
        if(attachmentList.size() > 0){
            insert attachmentList;
        }
    }*/
}








    /**
    * 
    *   @description    :   In this method we chacking the duplicate if then throw error and Potential Duplicate then relate that contact all related contacts.
    *
    *   @args           :   List of Contact.
    *
    *   @return         :   
    *
    *   @revision Log   :   V1.1 - Created  - 02/09/2021 - Rajat khatri
    * 
    **/
   /* public static void contactDuplicateAndPotentialDuplicateCheck(List<Contact> conList){
        //set to store the last name so we can apply soql query to fetch related contacts
        Set<String> lstName = new Set<String>();
        //set to store the email so we can apply soql query to fetch related contacts
        Set<String> email = new Set<String>();
        //set to store the phone so we can apply soql query to fetch related contacts
        Set<String> phn = new Set<String>();
        //map to store contact with contact unique key from trigger
        Map<String,Contact> mapContactFromTrigger = new Map<String,Contact>();
        //map to store contact with contact unique key from soql
        Map<String,Contact> mapContactFromsoql = new Map<String,Contact>();
        //checking the size of trigger contact list
        if(conList.size() > 0){
            //loop over the trigger contac list
            for(Contact con : conList){
                //checking the last name is not blank
                if(String.isNotBlank(con.LastName)){
                    //adding last name of contact from trigger contact list to set
                    lstName.add(con.LastName);
                    //adding email of contact from trigger contact list to set
                    email.add(con.Email);
                    //adding phone of contact from trigger contact list to set
                    phn.add(con.Phone); 
                    con.Related_Duplicate__c = '';
                    //creating the unique key of each contact
                    String key1 = con.LastName + '-' + con.Email + '-' + con.Phone;
                    //putting contact in map with unique key
                    mapContactFromTrigger.put(key1,con);
                }
            }
        }
        System.debug('Set of Lastname->' + lstName);
        System.debug('Set of Email->' + email);
        System.debug('Set of phn->' + phn);

        //applying the soql on contacts to fetch the related the contacts form the set which we populated from trigger contact list
        for(Contact cont :[SELECT LastName,Email,Phone FROM Contact WHERE (LastName IN :lstName or Email IN :email or Phone IN :phn)]){
            //making the unique key of each contact
           String key2 =  cont.LastName + '-' + cont.Email + '-' + cont.Phone;
           //putting contact in map with the unique key
           mapContactFromsoql.put(key2,cont);
        }
        System.debug('contact retrive from soql with the help of above sets->' + mapContactFromsoql);
        //loop over the trigger contact list for comparing
        for(Contact conn : conList){
            //checking the last name is not blank
            if(String.isNotBlank(conn.LastName)){
                //making the unique key of each contact
                String key3 = conn.LastName + '-' + conn.Email + '-' + conn.Phone;
                //checking thata the contact which is being inserted if it is exect duplicate or not
                if(mapContactFromsoql.containskey(key3)){
                    //when the conatct which is being inserted is exectly duplicate then we will give error
                    conn.addError('Use the Original contact rather then creating New One');
                }
                else{
                    //we will put all realted contacts in related duplicate feild
                    //to check all the related contacts we will run loop over the map keyset of soql map
                    for(String contt : mapContactFromsoql.keySet()){
                        //get the contact on that key
                        Contact contact = mapContactFromsoql.get(contt);
                        //check the conditions of related duplicate conatcts
                        if((contact.LastName == conn.LastName && contact.Email == conn.Email && contact.Phone != conn.Phone) ||
                            (contact.LastName != conn.LastName && contact.Email == conn.Email && contact.Phone == conn.Phone) ||
                            (contact.LastName == conn.LastName && contact.Email != conn.Email && contact.Phone == conn.Phone)){
                                //if we fine related then we turn the potential duplicate true
                                conn.Potential_Duplicate__c = True;
                                //making the string of related duplicate
                                String relatedDuplicate = 'LastName = '+ contact.LastName + ', Email = ' + contact.Email + ', Phone = ' + contact.Phone + '\n'; 
                                //add the string in the related duplicate feild
                                conn.Related_Duplicate__c = conn.Related_Duplicate__c + relatedDuplicate;
                            }
                        }
                    }
                }
            }
        }*/
    
    /**
    * 
    *   @description    :   In this method we checking the Email duplicate of Contact if duplicate found will throw error.
    *
    *   @args           :   List of Contact.
    *
    *   @return         :   
    *
    *   @revision Log   :   V1.1 - Created  - 04/15/2021 - Rajat khatri
    * 
    **/
   /* public static void contactEmailDuplicateCheck(List<Contact> contactList){
        //set to store the email of new Contact
        Set<String> setTostoreEmailOfNewContact = new Set<String>();
        Set<String> setOfDuplicateEmail = new Set<String>();
        //itrating on contactList
        for(Contact con :contactList){
            //Adding the new contact email in set
            setTostoreEmailOfNewContact.add(con.Email);
        }
        //fetching the same Email from database if they exist
        for(Contact cont :[SELECT Email FROM Contact WHERE Email IN :setTostoreEmailOfNewContact]){
            //addingbthe email in set
            setOfDuplicateEmail.add(cont.Email);
		}
        for(Contact conn :contactList){
            //checking is email is in retlived set
            if(setOfDuplicateEmail.contains(conn.Email)){
                conn.addError('This email already exist use different email or try to access contact with this email.');
                System.debug('This email already exist use different email or try to access contact with this email.');
            }
        }
      }*/
    /**
    * 
    *   @description    :   In this method we checking if contact have transaction Entries associated with it. that contact can not be Deleted.
    *
    *   @args           :   List of Contact.
    *
    *   @return         :   
    *
    *   @revision Log   :   V1.1 - Created  - 04/15/2021 - Rajat khatri
    * 
    **/
   /* public static void checkingContactCanBeDeleted(List<Contact> contactList){
        //to store the Id of contact for which we want to check Transaction Entries
        Set<Id> setOfContactId = new Set<Id>();
        //itrating on contact list which is passed in argument
        for(Contact con : contactList){
            //adding the Contact id in Set
            setOfContactId.add(con.Id);
        }
        //map to store the id of contact and transaction entries
        Map<Id,List<Transaction_Entry__c>> mapToStoreContactIdWithListOfTransactionEntries = new Map<Id,List<Transaction_Entry__c>>();
        //populating the map with contact id and Associated transaction entries
        for(Transaction_Entry__c tranEntry :[SELECT Id,Contact__c FROM Transaction_Entry__c WHERE Contact__c =:setOfContactId]){
            //checking is this ContactId is present or not 
            if(!mapToStoreContactIdWithListOfTransactionEntries.containsKey(tranEntry.Contact__c)){
                mapToStoreContactIdWithListOfTransactionEntries.put(tranEntry.Contact__c, new List<Transaction_Entry__c>());
            }
            //Adding tha values of Transaction entries
            mapToStoreContactIdWithListOfTransactionEntries.get(tranEntry.Contact__c).add(tranEntry);
        }
        //itrating on the argument passed Contact list
        for(Contact contacts : contactList){
            //getting all the transaction entries associated with contact
            List<Transaction_Entry__c> tranEntryList = mapToStoreContactIdWithListOfTransactionEntries.get(contacts.Id);
            //checking list is not null
            if(tranEntryList != null){
                //checking if the size is greater then 0 
                if(tranEntryList.size()>0){
                    //if size is greater then zero add error
                contacts.addError('This Contact has associated transaction entries so This Contact can not be deleted.');
                System.debug('This Contact has associated transaction entries so This Contact can not be deleted. =>' + tranEntryList.size());
                }
            }
            else{
                System.debug('This Contact can be deleted');
            }
        }
        
	}*/
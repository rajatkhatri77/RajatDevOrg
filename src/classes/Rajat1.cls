public class Rajat1 {
    public static void x(){
       
        
        
       
        
    }
}





 /**String xx = 'Contact Details :\n'+
    	'FirstName = raman1, LastName = Sharma1, Email = raman1@gmail.com\n'+
    	'FirstName = raman1, LastName = Sharma1, Email = raman1@gmail.com\n'+
        'FirstName = raman2, LastName = Sharma2, Email = raman2@gmail.com\n'+
        'FirstName = raman3, LastName = Sharma3, Email = raman3@gmail.com\n'+
        'FirstName = raman4, LastName = Sharma4, Email = raman4@gmail.com\n'+
        'FirstName = raman5, LastName = Sharma5, Email = raman5@gmail.com\n'+ 
    	'Opportunity Details :\n'+
    	'Name = TestOpp1, Type = Existing Customer - Upgrade\n'+
		'Name = TestOpp2, Type = Existing Customer - Replacement\n';
        
        List<String> rawstr = new List<String>(xx.split('\n'));
        System.debug('rawstr--> ' + rawstr);
       
        Set<String> contactDetails = new Set<String>();
        Set<String> oppDetails = new Set<String>();
        for(String s : rawstr){
            String s1 = s.substringBefore(' = ');
            if(s1 == 'FirstName'){
                contactDetails.add(s);
            }
            if(s1 == 'Name'){
                oppDetails.add(s);
            }
            
        }
        System.debug('Contact Details--> '+ contactDetails);
        System.debug('opp Details-->' + oppDetails);




 public static void x(){
        Set<String> lstnme = new Set<String>{'singh', 'agarwal', 'jain'};
            Set<String> email = new Set<String>{'singh@gmail.com', 'nandu@gmail.com','ajain@gmail.com'};
                Set<String> phn = new Set<String>{'7778882244', '8872998222', '8877899911'};
                    List<Contact> conlst = [SELECT LastName,Email,Phone FROM Contact WHERE (LastName IN :lstnme or Email IN :email or Phone IN :phn)];
        System.debug(conlst);
        
       
        
    }**/
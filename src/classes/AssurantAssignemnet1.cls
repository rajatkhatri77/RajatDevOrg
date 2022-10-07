/*Nornally just use of class and object*/
public class AssurantAssignemnet1 {
    public static String fistName = 'test';
    public static Integer randomNumber = Integer.valueof((Math.random() * 10));
    public static String lastName = 'Contact' + String.valueOf(randomNumber); 
   
    /* Method without Static keyword */
	public void createContact(){
        Contact con = new Contact();
		con.FirstName = fistName;
        con.LastName = lastName;
        con.Email = fistName+'.'+lastName + '@xyz.com';
        Insert con;
        System.debug('Created Contact -> '+con);
        
    }
    /* Method with Static keyword */
    public static void fetchContact(){
        Contact contact = [Select Id,FirstName, LastName, Email from Contact Limit 1];
		System.debug('fetchContact -> ' + contact);
    }

}
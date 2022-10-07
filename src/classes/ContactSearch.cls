public class ContactSearch {
    public static List<Contact> searchForContacts(string lastname, string mail){
        List<Contact> con = [SELECT Id,Name FROM Contact Where LastName=:lastname AND MailingPostalCode=:mail];
        return con;
        
    }

}
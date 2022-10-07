public class AccountHandler {
    public static Account insertNewAccount(string name){
        try{
            Account acc = new Account(Name = name);
            insert acc;
            return acc;
        }catch(DMLException e){
            return null;
        }
    }
}
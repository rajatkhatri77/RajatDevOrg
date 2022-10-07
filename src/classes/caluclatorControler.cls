public class caluclatorControler {
    @AuraEnabled
    public static decimal calculateTheSum(decimal fNumber, decimal sNumber){
        decimal sum = fNumber + sNumber;
        return sum;
    }
    @AuraEnabled
    public static String doSave(Contact conObj){
        System.debug(conObj);
        insert conObj;
        return conObj.Id;
    }
}
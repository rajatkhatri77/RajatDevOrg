public class TestobjectDAO implements ITestobjectDAO{
    public Interface ITestobjectDAO{
        List<Testobject__c> getAllRecordsOfTestObject();
    }
    public static List<Testobject__c> getAllRecordsOfTestObject(){
        return[Select Id, Name, currencyToPercentage__c, testDateToPercentToPickListToMultiPickLi__c from Testobject__c];
    }

}
public class Temp1forKYC {
    public static void temp(List<Contact> conn){
        List<AggregateResult> agg = [SELECT Contact__c, Status__c,Count(Id) FROM KYC_Detail__c WHERE Contact__c IN : conn GROUP BY Contact__c,Status__c];
        for(AggregateResult ar: agg){
            System.debug('-- ' + ar);
        }
    }

}
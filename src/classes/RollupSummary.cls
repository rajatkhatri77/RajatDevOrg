public with sharing class RollupSummary {
    public static void rollUpTaskInformations(){
        AggregateResult[] accountListWithAgg = [SELECT Id,Status,COUNT(AccountId) FROM Task WHERE ActivityDate <= 2021-01-30 GROUP BY Id,Status];
        for(AggregateResult agg : accountListWithAgg){
            System.debug(agg);
        }

    }
    }
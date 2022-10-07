@isTest
private class DailyLeadProcessorTest {
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    static testmethod void testScheduledJob(){
    List<Lead> leads = new List<Lead>();
    for(Integer i=0; i<200; i++){
        Lead l = new Lead(LastName = 'lead'+i, Company = 'Test');
        leads.add(l);
    }
    insert leads;
    Test.StartTest();
    String jobId = System.schedule('ScheduledApexTest', CRON_EXP, new DailyLeadProcessor());
    Test.stopTest();
    List<Lead>checkupdleads = new List<Lead>();
    checkupdleads = [SELECT Id FROM Lead WHERE LeadSource = 'Dreamforce' and Company = 'Test'];
    System.assertEquals(200,checkupdleads.size());

}
}
//('ScheduledApexTest',    ('ScheduledApexTest',CRON_EXP,new DailyProcessorTest());
           // CRON_EXP,
            //new DailyProcessorTest());
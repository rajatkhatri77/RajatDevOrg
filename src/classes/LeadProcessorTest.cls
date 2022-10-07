@isTest
private class LeadProcessorTest {
    @testSetup
    Static void Setup(){
        List<Lead> leads = new List<Lead>();
        for(Integer i=0; i<200;i++){
            leads.add(new Lead(LastName = 'Leads'+i,Company = 'Test'));
        }
        insert leads;
    }
    Static testmethod void test(){
        Test.startTest();
        LeadProcessor myleads = new LeadProcessor();
		Id batchId = Database.executeBatch(myleads);
        Test.stopTest();
        System.assertEquals(200,[SELECT count() FROM Lead WHERE LeadSource = 'Dreamforce']);
    }

}
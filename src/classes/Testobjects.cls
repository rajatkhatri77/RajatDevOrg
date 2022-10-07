public class Testobjects {
    @testVisible static private TestobjectDAO.ITestobjectDAO TestobjectDAOInstance = new TestobjectDAO();
    
    public static void testObjectMethod1(List<Testobject__c> testObjects){
        System.debug('Message from the Testobjects class');
        for(Testobject__c tobj : testObjects){
            System.debug(tobj);
        }
        List<Testobject__c> testobj = TestobjectDAOInstance.getAllRecordsOfTestObject();
        System.debug(testobj.size());
    }

}
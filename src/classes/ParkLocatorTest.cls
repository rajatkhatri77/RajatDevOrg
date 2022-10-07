@isTest
private class ParkLocatorTest {
    @isTest static void testCallout() {              
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        // Call the method that invokes a callout
        String country = 'India';
        List<String> parks = new List<String>();
               parks.add('Anamudi Shola National Park');
               parks.add('Anshi National Park');
               parks.add('Bandipur National Park');
        List<String> result = ParkLocator.country(country);
        // Verify that a fake result is returned
        System.assertEquals(parks, result); 
    }
}
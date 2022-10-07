public without sharing class TestobjectTriggerHandler extends TriggerHandler
{
    private static String handlerNameInternal = null;

    public TestobjectTriggerHandler() {
        
    }

    public override String getHandlerName() {
        if(handlerNameInternal == null) {
            handlerNameInternal = TestobjectTriggerHandler.class.getName();
        }
        return handlerNameInternal;
    }
	
	public override String getSObjectType() {
        return 'Testobject__c';
    }
}
public class TestobjectManagerTestObjRT1 implements IManager{
    
    public void beforeInsert(List<sObject> newObjList) {}
    public void beforeUpdate(List<sObject> newObjList, Map<Id,sObject> oldObjMap) {}
    public void beforeDelete(Map<Id, sObject> oldObjMap) {}
    public void afterInsert(List<sObject> newObjList) {
        List<Testobject__c> newTestobject = (List<Testobject__c>) newObjList;
        System.debug('New TeastObject Record created msg from Manager class');
        Testobjects.testObjectMethod1(newTestobject);
    }
    public void afterUpdate(List<sObject> newObjList, Map<Id,sObject> oldObjMap) {}
    public void afterDelete(Map<Id,sObject> oldObjMap) {}
    public void afterUndelete(List<sObject> newObjList) {}

}
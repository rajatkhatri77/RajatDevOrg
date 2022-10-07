public class Method {
    public static void method(){
        Map<Id,List<Contact>> idToLCon = new  Map<Id,List<Contact>>();
        List<Contact> acc = [SELECT Id from Contact];
        for(Contact a : acc){
            //List<Contact> con = new List<Contact>([SELECT Name FROM Contact WHERE Id=:a.Id]);
            idToLCon.put(a.Id, new List<Contact>([SELECT Name FROM Contact WHERE Id=:a.Id]));
            //idToLCon.get(a.Id).add([SELECT Name FROM Contact WHERE Id=:a.Id]);
        }
        System.debug('idToLCon: ' + idToLCon);
    }

}
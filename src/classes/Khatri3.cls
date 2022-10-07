public class Khatri3{
    public static void show(){
        List<String> setContactDetails = new List<String>{'FirstName=rajat44,LastName=khatri1,Email=rajatKhatri91044@gmail.com .','FirstName=rajat155,LastName=khatri155,Email=rajatKhatri910155@gmail.com .'};
        List<String> setContactOldDetails = new List<String>{'FirstName=rajat44,LastName=khatri1,Email=rajatKhatri91044@gmail.com .'};
            List<Integer> indx = new List<Integer>();
        for(String st : setContactOldDetails){
            for(String st1 : setContactDetails){
                if(st == st1){
                    System.debug('match');
                    Integer indx1 = setContactDetails.indexOf(st1);
                    indx.add(indx1);
                }
            }
        }
        for(Integer it : indx){
            setContactDetails.remove(it);
        }
        System.debug(setContactDetails);
    }
}
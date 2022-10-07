public class Khatri {
    public static void show(){
        Set<String> setnew = new Set<String>{'FirstName=Mohit,LastName=Doultani,Email=md03@gmail.com'
, 'FirstName=Rahul,LastName=makhija,Email=rm03@gmail.com'
, 'FirstName=harish,LastName=makhija,Email=hmak03@gmail.com', 'FirstName=harsh,LastName=Doultani,Email=harsh03@gmail.com'
, 'FirstName=kamal,LastName=Doultaniii,Email=kd03@gmail.com'
, 'FirstName=kamlesh,LastName=tejwani,Email=ktsh03@gmail.com'
};
            Set<String> setold = new Set<String>{'FirstName=Mohit,LastName=Doultani,Email=md03@gmail.com'
, 'FirstName=harsh,LastName=Doultani,Email=harsh03@gmail.com'
, 'FirstName=kamal,LastName=Doultaniii,Email=kd03@gmail.com'
, 'FirstName=kamlesh,LastName=tejwani,Email=ktsh03@gmail.com'};
                Set<String> new1 = new Set<String>();
        for(String xx : setnew){
            if(!setold.contains(xx)){
                new1.add(xx);
            }
        }
       
      
        System.debug('setnew' + setnew);
        System.debug('setold' + setold);
        System.debug('setnew1' + new1);
            
    }
}
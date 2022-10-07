public class khatri2 {
    public static void show(){
        String st = 'FirstName=rajat1,LastName=khatri1,Email=rajatKhatri9101@gmail.com .';
        Map<String,String> mapp = new Map<String,String>();
        string stt = st.substringBetween('FirstName=',',LastName=') + st.substringBetween(',LastName=',',Email=') + st.substringBetween(',Email=',' .');
        System.debug(stt);
   
}
}
/** Set<String> setNew = new Set<String>{'FirstName=Rohit,LastName=Sharmaji,Email=sharmajii54@gmail.com .',
        'FirstName=bhuvneshwar,LastName=kumar,Email=bk15@gmail.com .',
        'FirstName=jasprit,LastName=bhumra,Email=jass@gmail.com .'};
         Set<String> setOld = new Set<String>{'FirstName=Rohit,LastName=Sharmaji,Email=sharmajii54@gmail.com .'};
         Set<String> setNew1 = new Set<String>(); 
            for(String xx : setNew){
                    if(setOld.contains(xx) == False ){		
                        setNew1.add(xx);
                    }
                }
        System.debug(setNew1);**/
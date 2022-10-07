/**
*  Description     :  Explaning difference between passby value pass by reference
*
*  Created By      :  Rajat khatri
*
*  Created Date    :  06/27/2022
*
*  Revision Logs   :  V1.0 - Created - Rajat khatri 
*
**/
public class PassBy {
    public static void callvalue(Integer value){
        value *= 2; 
        System.debug('from method -> ' + value);
    }
    
    public static Integer callvalue2(Integer value){
        return value *= 2;
    }
    public static void callvalue3(List<Integer> integers){
        for(integer i=0; i<integers.size(); i++){
            integers[i] *= 2;
        }
        System.debug('list of integers in method -> '+ integers);
    }
    public static List<Integer> callvalue4(List<Integer> integersList){
        List<integer> shallowCopy = integersList;
        for(integer i=0; i<shallowCopy.size(); i++){
            shallowCopy[i] *= 2;
        }
        return shallowCopy;
    }
    public static Account callAcc(Account acc){
        Account acc1 = acc.clone();
        system.debug('Cloned -> ' + acc1);
        for(integer i=0; i<10;i++){
            acc1.Name = acc.Name + i;
        }
      System.debug('from method -> ' + acc.Name);
        return acc1;
    }

}
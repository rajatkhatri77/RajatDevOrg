public class AbstractChildClass extends AbstractParentClass{
    public Override void multiply(Integer a, Integer b){
        Integer result = a*b;
        System.debug('AbstractParentClass Abstract method defined -> ' + result);
    }
    public Override void add(Integer a, Integer b){
        Integer result = a+b;
        System.debug('AbstractParentClass Virtual method defined -> ' + result);
    }


}
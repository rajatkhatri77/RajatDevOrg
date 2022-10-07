public abstract class AbstractParentClass {
    public abstract void multiply(Integer a, Integer b);
    public virtual void add(Integer a, Integer b){
        System.debug('addintion from the Abstract class virtual method');
        System.debug(a+b);
    }

}
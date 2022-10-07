public class AssurantAssignemnet1InheritanceExtends extends ExtendedClass {
    public static void fetchVariable(){
        System.debug('Message from the extended class -> ' + ExtendedClass.testvar);   
    }
    public override void ExtendedClassMethod1() {
        System.debug('Debug from the Child class method ExtendedClassMethod1 which is overrided in the Child class');
        ExtendedClass extClass = new ExtendedClass();
        Contact parentClassMethodCallingContact = extClass.ExtendedClassMethod2();
        System.debug('calling ExtendedClassMethod1 from the ExtendedClass(parent class) -> ' + parentClassMethodCallingContact);
        super.ExtendedClassMethod3();
    }
    public void addition(Integer a, Integer b){
        Integer result = a+b;
        System.debug('Addition of two Number -> ' + result);
    }
	public void addition(Integer a, Integer b, Integer c){
        Integer result = a+b+c;
        System.debug('Addition of three Number -> ' + result);
    }
}
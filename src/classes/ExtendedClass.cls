public virtual class ExtendedClass {
    public static String testvar = 'This is test variable from ExtendedClass';
    public virtual void ExtendedClassMethod1() {
        System.debug('Debug from the ExtendedClass method ExtendedClassMethod1');
    }
	
    public Contact ExtendedClassMethod2() {
        Contact contact = [Select Id,FirstName, LastName, Email from Contact Limit 1];
		System.debug('fetchContact -> ' + contact);
        return contact;
    }
    
    public virtual void ExtendedClassMethod3() {
        System.debug('Debug from the ExtendedClass method ExtendedClassMethod3');
    }
}
public class lwctest {
    
     public list<selectoption> getoppst(){
        
        //Create a list of select option type
        list<selectoption> opt = new list<selectoption>();
        
        //FieldDescription=SObjectName.FieldName.getDescribe()
        schema.DescribeFieldResult fd = opportunity.stagename.getdescribe();
        
        //Get all picklist value in a list of scheme.picklistentry type
        list<Schema.PicklistEntry> pc = fd.getpicklistvalues();
        
        //Add each value in the list of selectoption
        for(Schema.PicklistEntry f: pc){
        
            opt.add(new selectoption(f.getlabel(),f.getvalue()));
        
        }
        
         /*for(selectoption lst : opt){
            // System.debug(lst);
         }*/
    
        return opt;
    }
}
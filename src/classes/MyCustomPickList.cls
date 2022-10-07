global class MyCustomPickList extends VisualEditor.DynamicPickList{
    String defaultVal = '--None--';



    
        
        
         /*for(selectoption lst : opt){
            // System.debug(lst);
         }*/
    
        //return opt;
    


    global override VisualEditor.DataRow getDefaultValue(){
        VisualEditor.DataRow defaultValue = new VisualEditor.DataRow(defaultVal,defaultVal);
        return defaultValue;
    }


    global override VisualEditor.DynamicPickListRows getValues() {



        //Create a list of select option type
        list<selectoption> opportunityStage = new list<selectoption>();
        
        //FieldDescription=SObjectName.FieldName.getDescribe()
        schema.DescribeFieldResult fd = opportunity.stagename.getdescribe();
        
        //Get all picklist value in a list of scheme.picklistentry type
        list<Schema.PicklistEntry> pc = fd.getpicklistvalues();
        
        //Add each value in the list of selectoption
        for(Schema.PicklistEntry f: pc){
        
            opportunityStage.add(new selectoption(f.getlabel(),f.getvalue()));
        
        
        }



        VisualEditor.DynamicPickListRows  myValues = new VisualEditor.DynamicPickListRows();

        //list<selectoption> optstg = getoppst();
        
        VisualEditor.DataRow noneValue = new VisualEditor.DataRow(defaultVal, defaultVal);

        myValues.addRow(noneValue);

        for(selectoption oppVal : opportunityStage){
            VisualEditor.DataRow value = new VisualEditor.DataRow(oppVal.getlabel(), oppVal.getvalue());//oppVal.optstg, oppVal.optstg
            myValues.addRow(value);
            
        }
        // VisualEditor.DataRow value1 = new VisualEditor.DataRow('red', 'RED');
        // VisualEditor.DataRow value2 = new VisualEditor.DataRow('yellow', 'YELLOW');
        // VisualEditor.DynamicPickListRows  myValues = new VisualEditor.DynamicPickListRows();
        // myValues.addRow(value1);
        // myValues.addRow(value2);
        return myValues;
    }
}
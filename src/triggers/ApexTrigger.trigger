trigger ApexTrigger on Lead (before insert) 

{

    /**** Bulkified Triggers ****/

    Lead l = Trigger.new[0]; // will only update the value for first record

    l.Rating = 'Warm'; //Avoid using Triggers like this

    //Always use Triggers in Bulkified form

    for(Lead l : Trigger.new) // will iterate through all the new records

    { 

        l.Rating = 'Warm';

    }

}
@IsTest
public  class TestFactoryDefaults{

    // To specify defaults for objects, use the naming convention [ObjectName]Defaults.
    // For custom objects, omit the __c from the Object Name

    public class AccountDefaults implements TestFactory.FieldDefaults {
        public Map<Schema.SObjectField, Object> getFieldDefaults() {
            System.debug('in Default class');
            return new Map<Schema.SObjectField, Object> {
                    Account.Name => 'Test Account',
                        Account.Phone => '9089876544'
            };
        }
    }

    public class MyAccountDefaults implements TestFactory.FieldDefaults {
        public Map<Schema.SObjectField, Object> getFieldDefaults() {
            return new Map<Schema.SObjectField, Object> {
                    Account.Name => 'My Test Account'
            };
        }
    }

    public class ContactDefaults implements TestFactory.FieldDefaults {
        public Map<Schema.SObjectField, Object> getFieldDefaults() {
            return new Map<Schema.SObjectField, Object> {
                    Contact.FirstName => 'First',
                    Contact.LastName => 'Last- ' + Crypto.getRandomInteger(),
                    Contact.Email => 'testuser' + crypto.getRandomInteger() + '@gmail.com',
                    Contact.Status__c => 'Active'
            };
        }
    }

    public class OpportunityDefaults implements TestFactory.FieldDefaults {
        public Map<Schema.SObjectField, Object> getFieldDefaults() {
            return new Map<Schema.SObjectField, Object> {
                    Opportunity.Name => 'Test Opportunity',
                    Opportunity.StageName => 'Closed Won',
                    Opportunity.CloseDate => System.today()
            };
        }
    }

    public class CaseDefaults implements TestFactory.FieldDefaults {
        public Map<Schema.SObjectField, Object> getFieldDefaults() {
            return new Map<Schema.SObjectField, Object> {
                    Case.Subject => 'Test Case'
            };
        }
    }
    
    public class Transaction_EntryDefaults implements TestFactory.FieldDefaults {
        public Map<Schema.SObjectField, Object> getFieldDefaults() {
            return new Map<Schema.SObjectField, Object> {
                    Transaction_Entry__c.Transaction_Date__c => Date.today(),
                    Transaction_Entry__c.Amount__c => 1000,
                    Transaction_Entry__c.Status__c => 'Completed',
                    Transaction_Entry__c.Type__c => 'Credit'
            };
        }
    }
}
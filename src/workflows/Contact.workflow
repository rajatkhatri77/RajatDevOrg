<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Send_Email_to_contact_on_Contact_created</fullName>
        <description>Send Email to contact on Contact created</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Email_on_contact_Created_With_WF</template>
    </alerts>
    <alerts>
        <fullName>sending_the_mail_to_contact_its_account_website</fullName>
        <ccEmails>rajat.khatri@fexle.com</ccEmails>
        <description>sending the mail to contact its account website</description>
        <protected>false</protected>
        <recipients>
            <recipient>rajatkhatri@fexle.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/from_contact_accessing_the_Account_Website</template>
    </alerts>
    <fieldUpdates>
        <fullName>check_box</fullName>
        <field>check_box__c</field>
        <literalValue>1</literalValue>
        <name>check box</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Email to contact on contact created</fullName>
        <actions>
            <name>Send_Email_to_contact_on_Contact_created</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>Email  &lt;&gt; null</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>WF_Contact_test</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Contact.AccountName</field>
            <operation>notEqual</operation>
            <value>null</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>contact isnull check</fullName>
        <actions>
            <name>check_box</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>CreatedBy.Profile.Name  = &quot;System Administrator&quot;</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>contact to account</fullName>
        <actions>
            <name>sending_the_mail_to_contact_its_account_website</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.for_workflow__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>

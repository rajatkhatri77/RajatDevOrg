<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Send_mail_for_workfole_rule</fullName>
        <description>Send mail for workfole rule</description>
        <protected>false</protected>
        <recipients>
            <field>Email_Address__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/workflow_Email_Alart</template>
    </alerts>
    <fieldUpdates>
        <fullName>out_of_state</fullName>
        <field>Out_Of_State__c</field>
        <literalValue>1</literalValue>
        <name>out of state</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>update</fullName>
        <field>updatedfield__c</field>
        <formula>inputfield__c  + 10</formula>
        <name>update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>updating_the_field_from_inputfielf_on_rk</fullName>
        <field>updatedfield__c</field>
        <name>updating the field from inputfielf on rk</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>RK Club Workflow rule</fullName>
        <actions>
            <name>Send_mail_for_workfole_rule</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>RK_Club__c.Vichal__c</field>
            <operation>equals</operation>
            <value>4 Wheel</value>
        </criteriaItems>
        <criteriaItems>
            <field>RK_Club__c.Mothly_income__c</field>
            <operation>greaterOrEqual</operation>
            <value>&quot;USD 20,000&quot;</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>iti poc for workflow</fullName>
        <actions>
            <name>update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>RK_Club__c.iti_case__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>out of state</fullName>
        <actions>
            <name>out_of_state</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>RK_Club__c.Destination_State__c</field>
            <operation>notEqual</operation>
            <value>Rajasthan</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>

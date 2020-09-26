/**
 * Created by Sergey on 24.09.2020.
 */

/*Create Queueble Job to perform similar logic:
a.       For accounts in which BillingAddress is not empty select all related Contacts
b.       Set to all Contacts Is Synced = false;


 Processed By Queue = true;
c. */
@IsTest
private class QueueableJobTest {

    @TestSetup
    static void init(){
        Account account = new Account(Name = 'Test account',
            BillingStreet = 'Test billing street',
            BillingPostalCode = ' ',
            BillingCity = ' ',
            BillingCountry = ' ',
            BillingState = ' ');
        insert account;
        Contact contact = new Contact(LastName = 'Test lastName', Is_Synced__c = true, AccountId = account.Id);
        insert contact;

    }

    @IsTest static void executeMethodTest(){
        System.Test.startTest();
        System.enqueueJob(new QueueableJob());
        System.Test.stopTest();
        List<Contact> contacts = [SELECT Id,Is_Synced__c FROM Contact];
        for (Contact contact : contacts) {
            System.assert(!contact.Is_Synced__c);

        }
    }
}

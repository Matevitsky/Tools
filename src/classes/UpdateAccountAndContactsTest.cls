/**
 * Created by Sergey on 23.09.2020.
 */
/*Create Batch Job which select all Сontacts with Is Synced = false
a. Batch should copy from Account.BillingAddress to Contact.MailingAddress
b. Set Contact.IsSynced__c = true;
c. Update Account field Updated By Contact = true;
d. Use Query Locator*/
@IsTest
private class UpdateAccountAndContactsTest {

    @TestSetup
    static void init() {

        Account account = new Account(Name = 'Test account',
            BillingStreet = 'Test billing street',
            BillingPostalCode = ' ',
            BillingCity = ' ',
            BillingCountry = ' ',
            BillingState = ' ');
        insert account;
        Contact contact = new Contact(LastName = 'Test lastName', Is_Synced__c = false, AccountId = account.Id);
        insert contact;

    }

    @IsTest static void updateTest() {
        List<Contact> contacts = [SELECT Id,Is_Synced__c,MailingStreet,AccountId FROM Contact];
        System.Test.startTest();
        UpdateAccountAndContacts updateAccountAndContacts = new UpdateAccountAndContacts();
        updateAccountAndContacts.updateRecords(contacts);
        System.Test.stopTest();
        for (Contact contact : contacts) {
            System.assert(contact.Is_Synced__c);
            System.assert(contact.MailingStreet == 'Test billing street');
        }

    }
}

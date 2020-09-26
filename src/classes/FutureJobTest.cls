/**
 * Created by Sergey on 23.09.2020.
 */

@IsTest
private class FutureJobTest {

    @TestSetup
    static void init() {
        Account account = new Account(Name = 'test', BillingStreet = 'test street');
        Account account2 = new Account(Name = 'test2');
        insert account;
        insert account2;

        Contact contact = new Contact(AccountId = account.Id);
        contact.FirstName = 'Test contact';
        contact.LastName = 'Test contact';

        Contact contact1 = new Contact(AccountId = account2.Id);
        contact1.FirstName = 'Test contact1';
        contact1.LastName = 'Test contact1';
        insert contact;
        insert contact1;
    }

    @IsTest static void updateContactsTest() {
        Account account = [SELECT Id FROM Account LIMIT 1];
        System.Test.startTest();
        FutureJob.updateContacts();
        System.Test.stopTest();

        List<Contact> resultContacts = [
            SELECT Id,Is_Synced__c, Processed_By_Future__c
            FROM Contact
            WHERE AccountId = :account.Id
        ];
        for (Contact contact : resultContacts) {
            System.assert(contact.Processed_By_Future__c == true);
        }
    }

    @IsTest static void testIfAccountWithoutBillingAddress() {
        List<Account> accounts = [SELECT Id FROM Account];
        System.Test.startTest();
        FutureJob.updateContacts();
        System.Test.stopTest();

        List<Contact> resultContacts = [
            SELECT Id,Is_Synced__c, Processed_By_Future__c
            FROM Contact
            WHERE AccountId IN :accounts AND FirstName ='Test contact1'
        ];
        for (Contact contact : resultContacts) {

            System.assert(contact.Processed_By_Future__c != true);
        }
    }
}

/**
 * Created by Sergey on 24.09.2020.
 */

/*Create Batch Job which select all Сontacts with Is Synced = false
a.       Batch should copy from Account.BillingAddress to Contact.MailingAddress
b.       Set Contact.IsSynced__c = true;
c.        Update Account field Updated By Contact = true;
d.       Use Query Locator*/
@IsTest
private class BatchJobTest {

    @TestSetup
    static void init(){
        Account account = new Account(Name = 'Test account', Updated_By_Contact__c = false,
            BillingStreet = 'Test billing street',
            BillingPostalCode = ' ',
            BillingCity = ' ',
            BillingCountry = ' ',
            BillingState = ' ');
        insert account;
        Contact contact = new Contact(LastName = 'Test lastName', Is_Synced__c = false, AccountId = account.Id);
        insert contact;

    }

    @IsTest static void executeTest() {
        System.Test.startTest();
        BatchJob batchJob = new BatchJob();
        Database.executeBatch(batchJob);
        System.Test.stopTest();
        List<Account> accounts = [SELECT Id, Updated_By_Contact__c FROM Account];
        List<Contact> relatedContacts = [SELECT Id,Is_Synced__c,MailingStreet FROM Contact WHERE AccountId IN :accounts] ;

        for (Contact contact : relatedContacts) {
            System.assert(contact.Is_Synced__c);
            System.assert(contact.MailingStreet == 'Test billing street');
        }
        for (Account account:accounts){
            System.assert(account.Updated_By_Contact__c);
        }
    }
}

/**
 * Created by Sergey on 11.09.2020.
 */
/*Create Batch Job which select all Сontacts with Is Synced = false
a.       Batch should copy from Account.BillingAddress to Contact.MailingAddress
b.       Set Contact.IsSynced__c = true;
c.        Update Account field Updated By Contact = true;
d.       Use Query Locator*/
public class BatchJob implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext param1) {
        return Database.getQueryLocator([
            SELECT AccountId, MailingPostalCode,MailingCity,MailingCountry,MailingState,
                MailingStreet,Is_Synced__c
            FROM Contact
            WHERE Is_Synced__c = FALSE
        ]);
    }
    public void execute(Database.BatchableContext param1, List<Contact> contacts) {
        UpdateAccountAndContacts updateAccountAndContacts = new UpdateAccountAndContacts();
        updateAccountAndContacts.updateRecords(contacts);
    }
    public void finish(Database.BatchableContext param1) {
    }
}

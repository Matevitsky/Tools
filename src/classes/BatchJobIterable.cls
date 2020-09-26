/**
 * Created by Sergey on 12.09.2020.
 */

public class BatchJobIterable implements Database.Batchable<Contact> {

    public List<Contact> start(Database.BatchableContext info) {
        return [
            SELECT AccountId, MailingPostalCode,MailingCity,MailingCountry,MailingState,
                MailingStreet,Is_Synced__c
            FROM Contact
            WHERE Is_Synced__c = FALSE
        ];
    }
    public void execute(Database.BatchableContext info, List<Contact> contacts) {
        UpdateAccountAndContacts up = new UpdateAccountAndContacts();
        up.updateRecords(contacts);
    }
    public void finish(Database.BatchableContext info) {
    }
}
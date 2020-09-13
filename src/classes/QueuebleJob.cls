/**
 * Created by Sergey on 11.09.2020.
 */


/*Create Queueble Job to perform similar logic:
a.       For accounts in which BillingAddress is not empty select all related Contacts
b.       Set to all Contacts Is Synced = false;


 Processed By Queue = true;
c.        Run created class using DevConsole.*/

public with sharing class QueuebleJob implements Queueable {

    public void execute(QueueableContext context) {

        List<Account> accounts = [SELECT Id,BillingAddress FROM Account];
        List<Contact> relatedContacts = new List<Contact>();
        for (Account account : accounts) {
            if (account.BillingAddress != null) {
                relatedContacts.addAll([SELECT Id,Is_Synced__c, Processed_By_Future__c FROM Contact WHERE AccountId = :account.Id]);
            }
        }
        relatedContacts = setIsSyncedTrue(relatedContacts);
        relatedContacts = setProcessedByQueueTrue(relatedContacts);
        update(relatedContacts);
    }
    private static List<Contact> setProcessedByQueueTrue(List<Contact> relatedContacts) {
        for (Contact contact : relatedContacts) {
            contact.Processed_By_Queue__c = true;
        }
        return relatedContacts;
    }
    private static List<Contact> setIsSyncedTrue(List<Contact> relatedContacts) {
        for (Contact contact : relatedContacts) {
            contact.Is_Synced__c = false;
        }
        return relatedContacts;
    }



}

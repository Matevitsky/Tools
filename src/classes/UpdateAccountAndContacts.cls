/**
 * Created by Sergey on 12.09.2020.
 */

global class UpdateAccountAndContacts {

    global void updateRecords(List<Contact> contacts) {
        List<Account> relatedAccounts = getRelatedAccounts(contacts);
        updateContactAndAccount(relatedAccounts, contacts);

    }
    private void updateContactAndAccount(List<Account> relatedAccounts, List<Contact> contacts) {
        for (Account account : relatedAccounts) {
            for (Contact contact : contacts) {
                if (account.Id == contact.AccountId) {
                    updateContact(contact, account);
                    account.Updated_By_Contact__c = true;
                }
            }
        }
        update(relatedAccounts);
        update(contacts);
    }

    private void updateContact(Contact contact, Account account) {
        contact.MailingPostalCode = account.BillingPostalCode;
        contact.MailingCity = account.BillingCity;
        contact.MailingCountry = account.BillingCountry;
        contact.MailingState = account.BillingState;
        contact.MailingStreet = account.BillingStreet;
        contact.Is_Synced__c = true;
    }

    private List<Account> getRelatedAccounts(List<Contact> contacts) {
        List<Account> relatedAccounts = new List<Account>();
        List<Id> accountIds = new List<Id>();

        for (Contact contact : contacts) {
            accountIds.add(contact.AccountId);
        }

        relatedAccounts.addAll([SELECT Id,BillingPostalCode,BillingCity,BillingCountry,BillingState,BillingStreet
        FROM Account WHERE Id IN :accountIds]);

        return relatedAccounts;
    }
}

/**
 * Created by Sergey on 11.09.2020.
 */


public class FutureJob {

    @Future
    public static void updateContacts() {
        List<Account> accounts = [SELECT Id, BillingAddress FROM Account LIMIT 150];
        List<Contact> relatedContacts = getRelatedContactsWithBillingAddress(accounts);
        updateContactFields(relatedContacts);
        update(relatedContacts);
    }

    private static List<Contact> getRelatedContactsWithBillingAddress(List<Account> accounts) {
        List<Contact> contacts = new List<Contact>();
        List<Account> accountWithBillingAddress = getAccountsWithBillingAddress(accounts);
        contacts.addAll([SELECT Id, Is_Synced__c,Processed_By_Future__c FROM Contact WHERE AccountId IN :accountWithBillingAddress]);
        return contacts;
    }

    private static List<Account> getAccountsWithBillingAddress(List<Account> accounts) {
        List<Account> accountWithBillingAddress = new List<Account>();
        for (Account account : accounts) {
            if (account.BillingAddress != null) {
                accountWithBillingAddress.add(account);
            }
        }
        return accountWithBillingAddress;
    }

    private static void updateContactFields(List<Contact> contacts) {
        for (Contact contact : contacts) {
            contact.Is_Synced__c = false;
            contact.Processed_By_Future__c = true;
        }
    }
}

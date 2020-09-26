/**
 * Created by Sergey on 23.09.2020.
 */
@IsTest
private class AccountTriggerHandlerHelperTest {

    @IsTest static void updateFieldOnlyOnce() {
        List<Account> accounts = new List<Account>();
        Account account = new Account(Name = 'Test');
        accounts.add(account);
        System.Test.startTest();
        AccountTriggerHandlerHelper.insertSingleAdditionalAccount(accounts);
        List<Account> created = [SELECT Id,Name FROM Account WHERE Name LIKE '%by trigger%'];
        System.Test.stopTest();

        System.assertEquals(accounts.size(), created.size());
    }
}

/**
 * Created by Sergey on 22.09.2020.
 */

public class AccountTriggerHandler {
    public static void beforeInsert(List<SObject> newAccounts) {
        List<Account> accounts = (List<Account>) newAccounts;
        AccountTriggerHandlerHelper.insertSingleAdditionalAccount(accounts);
    }
}

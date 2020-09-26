/**
 * Created by Sergey on 22.09.2020.
 */

public class AccountTriggerHandlerHelper {
    public static void insertSingleAdditionalAccount(List <Account> newAccounts) {

        List<Account> createdAccounts = new List<Account>();

        if (TriggerBlockerHelper.triggerFired == false) {
            TriggerBlockerHelper.triggerFired = true;
            for (Account account : newAccounts) {
                Account created = new Account(Name = account.Name + ' by trigger');
                createdAccounts.add(created);
            }
            insert createdAccounts;
        }
    }
}

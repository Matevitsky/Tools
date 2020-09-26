/**
 * Created by Sergey on 17.09.2020.
 */

@RestResource(UrlMapping = '/v1/Account/*')
global with sharing class AccountRestController {

    @HttpGet
    global static Account getAccountById() {
        RestRequest req = RestContext.request;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
        Account account = [SELECT Id, Name, Phone, Website FROM Account WHERE Id = :accountId];

        return account;
    }

    @HttpPost
    global static Id saveAccount(String name) {
        Account account = new Account(Name = name);
        insert account;
        return account.Id;

    }

    @HttpDelete
    global static void deleteAccount() {
        RestRequest req = RestContext.request;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
        Account account = [SELECT Id FROM Account WHERE Id = :accountId];
        delete account;
    }

    @HttpPut
    global static Id upsertAccount(String name,String accountId) {
        Account account = new Account();
        if(String.isNotEmpty(accountId)){
            account.Id = accountId;
        }
        account.Name = name;
        upsert account;
        return account.Id;
    }

    @HttpPatch
    global static Id updateAccountFields(){
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Account account = [SELECT Id FROM Account WHERE Id = :accountId];

        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestBody.toString());

        for(String fieldName : params.keySet()) {

            account.put(fieldName, params.get(fieldName));
        }
        update account;
        return account.Id;
    }
}

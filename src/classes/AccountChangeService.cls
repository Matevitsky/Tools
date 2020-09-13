/**
 * Created by Sergey on 09.09.2020.
 */

global class AccountChangeService {

    @InvocableMethod(Label = 'Handle account change' Category = 'Account')
    global static void accountChangeHandler(List<ChangeAccountRequest> cTaskRequests) {
        for (ChangeAccountRequest request : cTaskRequests) {
            assignTask(request);
        }

    }

    public static void assignTask(ChangeAccountRequest request) {
        if (AccountIsCreated(request)) {
            Task newTask = createNewTask(request.account);
            insert(newTask);
        } else {
            List<Task> taskList = [SELECT Id, OwnerId FROM Task WHERE AccountId = :request.account.Id];
            if (taskList.size() > 3) {
                List<User> activeUsers = [SELECT Id FROM User WHERE IsActive = TRUE];
                assignAccountTasksToRandomUser(activeUsers, taskList);
            }
        }
    }

    private static Boolean AccountIsCreated(ChangeAccountRequest request) {
        return request.account.Tasks.size() == 0;
    }

    private static void assignAccountTasksToRandomUser(List<User> activeUsers, List<Task> taskList) {

        Integer userNumber = Integer.valueOf((Math.random() * activeUsers.size()));
        User userForAssignTask = activeUsers.get(userNumber);

        for (Task task : taskList) {
            task.OwnerId = userForAssignTask.Id;

        }
        update(taskList);
    }

    private static Task createNewTask(Account account) {
        Task newTask = new Task(Subject = 'Negotiations with ' + account.Name);
        newTask.WhatId = account.Id;
        return newTask;
    }
    global class ChangeAccountRequest {

        @InvocableVariable(Required=true)
        public Account account;

    }
}

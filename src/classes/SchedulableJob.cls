global class SchedulableJob implements Schedulable{

    global void execute(SchedulableContext param1) {
        System.debug('SchedulableJob started');
        BatchJob batchJob = new BatchJob();
            Database.executeBatch(batchJob);
    }
}

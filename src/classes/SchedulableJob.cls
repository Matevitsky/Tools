global class SchedulableJob implements Schedulable {

    global void execute(SchedulableContext param1) {

        BatchJob batchJob = new BatchJob();
        BatchJobIterable batchJobIterable = new BatchJobIterable();
        Database.executeBatch(batchJob);
        Database.executeBatch(batchJobIterable);
    }
}

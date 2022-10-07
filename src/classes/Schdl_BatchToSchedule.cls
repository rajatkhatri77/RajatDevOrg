global class Schdl_BatchToSchedule implements Schedulable{
    global void execute(SchedulableContext ctx){
        Batch_BatchAndSchedule Batch = new Batch_BatchAndSchedule();
        String CRON_EXP ='0 0 * ? * * *';
        String jobId = System.schedule('ScheduledApexTest', CRON_EXP, Batch);
    }
}
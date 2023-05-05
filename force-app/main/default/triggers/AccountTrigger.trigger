trigger AccountTrigger on Account (after insert) {
    // if(trigger.isBefore && trigger.isInsert ){
	// 	AccountTriggerHandler.CreateAccounts(Trigger.New);
    //     }

 

        for(Account acc :Trigger.new){
            FutureTaskCreator.createTask(acc.Id);
            QueuableTaskCreator qjob= new QueuableTaskCreator(acc.Id);
            ID jobId =System.enqueueJob(qjob);
            System.debug('Queuable Job ID'+ jobId);
        }
   
}
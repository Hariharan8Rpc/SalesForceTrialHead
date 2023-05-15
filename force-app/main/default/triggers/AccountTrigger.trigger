trigger AccountTrigger on Account (after insert,before insert) {
    // if(trigger.isBefore && trigger.isInsert ){
	// 	AccountTriggerHandler.CreateAccounts(Trigger.New);
    //     }

List<Contact> contacts=new List<Contact>();
        for(Account acc :Trigger.new){
           
            FutureTaskCreator.createTask(acc.Id);
            QueuableTaskCreator qjob= new QueuableTaskCreator(acc.Id);
            ID jobId =System.enqueueJob(qjob);
            System.debug('Queuable Job ID'+ jobId);    
            // String existingAccId=acc.Id;
            // String existingAccName=acc.Name;              
    
            // for (Integer index=1; index <= 500; index++) {
            //     Contact con=new Contact(LastName=existingAccName+' - '+string.valueOf(index),AccountId =existingAccId);
            //   insert con;
            //     //  contacts.add(con);
            }
        }
      //  insert contacts;
public class Batcheg implements Database.Batchable<sObject>, Database.Stateful {
//Create a batch class which will automatically display the number of days since the contact was created 
//Read through cron objects 
//  Id batchJobId = Database.executeBatch(new RunThisBatch(), 200);
public Integer records=0;

    public Database.QueryLocator start(Database.BatchableContext bc) {
       String name='Amruthesh';
        return Database.getQueryLocator(
      	'SELECT createddate,Name FROM Contact where Name=:name'
      );
    }
    
    public void execute(Database.BatchableContext bc, List<Contact> conList){
        System.debug('Entered execute method');
       // Date today = Date.today();
       // List<Contact> contactList=new List<Contact>();
        //for(Contact con : conlist){
         //   Date myDate=con.CreatedDate.Date();
         //   con.Created_Day_Count__c=myDate.daysBetween(today);
         //  contactList.add(con);
       // }
       // update contactList;
    }

    public void finish(Database.BatchableContext bc){
        // execute any post-processing operations
        System.debug('---'+records);
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
            JobItemsProcessed,
            TotalJobItems
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
        System.debug(job.NumberOfErrors+'------'+job.Status);
    }
}
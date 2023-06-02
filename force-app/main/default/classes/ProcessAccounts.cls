global with sharing class ProcessAccounts implements Database.Batchable<Sobject>,Database.Stateful {
   
    global Database.QueryLocator start(Database.BatchableContext bc){
        return  Database.getQueryLocator([SELECT Id,Name,AccountNumber from Account]);
    }
    Integer accNumber =0;
       global void execute(Database.BatchableContext bc ,List<Account> records){
        for(Account acc:records){
            acc.AccountNumber=String.valueOf(accNumber);
        }
        accNumber=accNumber+1;
        update records;
    }
    global void finish(Database.BatchableContext bc){

    }
}
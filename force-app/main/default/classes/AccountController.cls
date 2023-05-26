public with sharing class AccountController {
  public static List<Account> getAllActiveAccounts() {
    System.debug('reffijiooookkmmote tunel access');
    return [SELECT Id, Name, Active__c FROM Account WHERE Active__c = 'Yes' WITH SECURITY_ENFORCED];    
  }
}
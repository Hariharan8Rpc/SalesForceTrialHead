public class ExtensionEmployeeController {
	private final Employee__c emp;
    
  public List<Employee__c> employeList{get;set;}
    
    
    public ExtensionEmployeeController(ApexPages.StandardController stdController) {
        this.emp = (Employee__c)stdController.getRecord();
    }
    
    public String getGreeting() {
        return 'Hello ' + emp.Name + ' (' + emp.id + ')';
    }
}
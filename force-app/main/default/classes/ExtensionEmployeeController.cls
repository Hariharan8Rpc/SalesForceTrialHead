public class ExtensionEmployeeController {
    public class EmployeeProject{
        Employee__c employee;
        List<Project__c> projects =new List<Project__c>();
  	    Address__c addr=new Address__c();
    }
    
  //public static List<EmployeeProject> empProject {get;set;}
    public static List<EmployeeProject> empProject =new  List<EmployeeProject> ();
    public static void getEmployees(){
    Set<Id> idSet = new Set<Id>();
        
    List<Employee__c> employees = [SELECT Id FROM Employee__c];
        for(Employee__c emp1 :employees){
         EmployeeProject empProject1= new EmployeeProject();
            
         // to get employee detail
        Employee__c employee=[
            SELECT id,Name,Address__c,Department__c 
            From Employee__c where id=:emp1.Id
        ];
            //assigning to local obj
            empProject1.employee=employee;
            System.debug('employee detail '+empProject1.employee);
      
            Address__c addr=new Address__c();
          
            
   		// to get projects
        List<Project__c> projectList = new List<Project__c>();
        List<EmployeeProject__c> employeeProjects = [
            SELECT Project__r.Id, Project__r.Name, Project__r.Domain__c, Project__r.Duration__c, Project__r.Priority__c
            FROM EmployeeProject__c
            WHERE Employee__r.Id = :emp1.Id
        ];
		
        for (EmployeeProject__c empProject : employeeProjects) {
            Project__c project = empProject.Project__r;
            projectList.add(project);
        }
            //assigning projects to local obj
            empProject1.projects=projectList;
             System.debug('employee detail '+empProject1.projects);
              System.debug('employee  '+empProject1);
             empProject.add(empProject1);
          
        }     
           System.debug('final obj'+empProject);
    }    
    public ExtensionEmployeeController() {
      getEmployees();
     }
    
}
public class ExtensionEmployeeController {
    
    public List<Project__c> projectsList { get; set; }
    public string EmployeeSearchId {get;set;}

    public class EmployeeProject{
        public Employee__c employee { get; set; }
        public List<Project__c> projects { get; set; }
        public Address__c addr { get; set; }

    public EmployeeProject() {
        employee = new Employee__c();
        projects = new List<Project__c>();
        addr = new Address__c();
    }
    }
    
  Public  List<EmployeeProject> empProject{get;set;}
 //   public  List<EmployeeProject> empProject =new  List<EmployeeProject> ();
    public  void getEmployees(){
    Set<Id> idSet = new Set<Id>();
    empProject = new List<EmployeeProject>();
    List<Employee__c> employees = [SELECT Id FROM Employee__c];
        for(Employee__c emp1 :employees){            
         EmployeeProject empProject1= new EmployeeProject();            
         // to get employee detail addr field removed
         Employee__c employee=[
            SELECT id,Name,Department__c 
            From Employee__c where id=:emp1.Id
        ];
            // employee detail assigning to local obj
            empProject1.employee=employee;
         //   System.debug('employee detail '+empProject1.employee);
      
            Address__c addr=new Address__c();
            addr=[Select id,name,city__c,state__c,Pincode__c from Address__c where Employee__r.Id=:emp1.Id];
			empProject1.addr=addr;    
          //  system.debug('Address'+addr);
            empProject1.projects=GetEmployeesproject(emp1.Id);
   		// to get projects
  /*     List<Project__c> projectList = new List<Project__c>();
        List<EmployeeProject__c> employeeProjects = [
            SELECT Project__r.Id, Project__r.Name, Project__r.Domain__c, Project__r.Duration__c, Project__r.Priority__c
            FROM EmployeeProject__c
            WHERE Employee__r.Id = :emp1.Id
        ];
		
        for (EmployeeProject__c empProject : employeeProjects) {
            Project__c project = empProject.Project__r;
            projectList.add(project);
        }
*/
            //assigning projects to local obj
           // empProject1.projects=projectList;
          
          System.debug('Project '+empProject1.projects);
             empProject.add(empProject1);
          
        } 
 /*       
        for(EmployeeProject pro:empProject){
            System.debug('employee '+pro.employee.Name);
            for(Project__c project:pro.projects){
				system.debug('projects'+ project.Name);
                system.debug('projects'+ project.Domain__c);
            }
        }
*/
           System.debug('final obj'+empProject);
    }   
    
    public ExtensionEmployeeController() {
      getEmployees();
      GetAllProjects();
     }
    
    public List<Project__c> GetEmployeesproject(Id emp1){
	//	EmployeeSearchId
          List<Project__c> projectList = new List<Project__c>();
           List<EmployeeProject__c> employeeProjects = [
            SELECT Project__r.Id, Project__r.Name, Project__r.Domain__c, Project__r.Duration__c, Project__r.Priority__c
            FROM EmployeeProject__c
            WHERE Employee__r.Id = :emp1
        ];
		
        for (EmployeeProject__c empProject : employeeProjects) {
            Project__c project = empProject.Project__r;
            projectList.add(project);
        }
        return projectList;
    }
    
    
    public void getProjectsRelatedToEmployee(){
     Id empid = Id.valueOf(EmployeeSearchId);  
	 projectsList=GetEmployeesproject(empid);
    }
    
    public void GetAllProjects(){
        //  List<Project__c> projectList = new List<Project__c>();
		projectsList=[Select id,Name,Domain__c,Duration__c,Priority__c from Project__c];
    }
   
 }
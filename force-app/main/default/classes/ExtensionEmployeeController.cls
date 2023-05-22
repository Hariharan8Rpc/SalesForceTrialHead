public  class ExtensionEmployeeController {
    public List<Project__c> projectsList { get; set; }
    public List<Project__c> projectsList1 { get; set; }
    public EmployeeProject SingleEmplist{get;set;}
    Public  List<EmployeeProject> empProject{get;set;}
    public Id EmployeeSearchId {get;set;}
    public Project__c project{get;set;}
    public boolean flag{get;set;}
    public boolean flag1{get;set;}
    Public  List<EmployeeProject> empInProject{get;set;}
    
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
 //   public  List<EmployeeProject> empProject =new  List<EmployeeProject> ();
    public  void getEmployees(){      
    empProject = new List<EmployeeProject>();
    List<Employee__c> employees = [SELECT Id FROM Employee__c];
        for(Employee__c emp1 :employees){            
         EmployeeProject empProject1= new EmployeeProject();            
         // to get employee detail addr field removed
         Employee__c employee=[
            SELECT id,Name,Department__c 
            From Employee__c where id=:emp1.Id
        ];
            empProject1.employee=employee;
           
      List<Address__c> address;   
      address = [SELECT Id, Name, City__c, State__c, Pincode__c FROM Address__c WHERE Employee__r.Id = :emp1.Id];
        if (address != null && address.size() > 0) {
        Address__c addr = address[0];
            empProject1.addr=addr;
             System.debug('null in  addr object'+addr);
       } else {
          System.debug('null in  addr object');
       }     
          //  system.debug('Address'+addr);
            empProject1.projects=GetEmployeesproject(emp1.Id);   		
          System.debug('Project '+empProject1.projects);
             empProject.add(empProject1);          
        } 
           System.debug('final obj'+empProject);
    }   
    
    public ExtensionEmployeeController() {
      getEmployees();
      GetAllProjects();
       flag=false;
       flag1=false;
       
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
        flag=true;
         system.debug('flag value in page  after initiate '+flag);
        EmployeeProject SingleEmplist1= new EmployeeProject();
        SingleEmplist1.projects=GetEmployeesproject(EmployeeSearchId);
        SingleEmplist1.employee=[
                SELECT id,Name,Department__c 
                From Employee__c where id=:EmployeeSearchId
            ];
        List<Address__c> address;   
       address = [SELECT Id, Name, City__c, State__c, Pincode__c FROM Address__c WHERE Employee__r.Id = :EmployeeSearchId];
        if (address != null && address.size() > 0) {
        Address__c addr = address[0];
           SingleEmplist1.addr=addr;
             System.debug('null in  addr object'+addr);
       } else {
          System.debug('null in  addr object');
       } 
        
        
        
     //   SingleEmplist1.addr=[Select id,name,city__c,state__c,Pincode__c from Address__c where Employee__r.Id=:EmployeeSearchId];
        SingleEmplist=SingleEmplist1;
        System.debug('Single EMp list'+SingleEmplist);
        
	//projectsList1=GetEmployeesproject(EmployeeSearchId);
        for( Project__c pro:SingleEmplist.projects){
            System.debug('project name '+pro.Name);
        }
    //    system.debug('single emp list1  '+ SingleEmplist.projects.size!=0);
        
        if(SingleEmplist==null){
             system.debug('single emp list1 inide if '+ SingleEmplist);
        }else{
            system.debug('single emp list1 inside else  '+ SingleEmplist);
        }
        system.debug('employee id from the get projec t methid'+SingleEmplist.projects);
 //       system.debug('employee111111 id from the get projec t methid'+empId1+'org id '+empid);
    }
    
    public void GetAllProjects(){
        //  List<Project__c> projectList = new List<Project__c>();
		projectsList=[Select id,Name,Domain__c,Duration__c,Priority__c from Project__c];
    }
    
    public void getEmployeesRelatedToProject(){
        flag1=true;
		system.debug(EmployeeSearchId+'id  Project  id');
        Set<Id> idSet = new Set<Id>();
        project=[select id, Name ,Domain__C,Duration__c,Priority__C from Project__C where id=:EmployeeSearchId];
    empProject = new List<EmployeeProject>();
    List<EmployeeProject__c> employees = [SELECT Employee__r.Id, Employee__r.Name, Employee__r.Department__c FROM EmployeeProject__c WHERE Project__r.Id =:EmployeeSearchId];            
        
        for(EmployeeProject__c employeeProj :employees){ 
              EmployeeProject empProject1= new EmployeeProject();    
            System.debug('inside the for of emp related to the projecrt'+employeeProj.employee__r.Id);
            empProject1.employee=employeeProj.employee__r;
          //   Address__c addr=new Address__c();
        empProject1.addr=[Select id,name,city__c,state__c,Pincode__c from Address__c where Employee__r.Id=:empProject1.employee.Id];		
             
            empProject.add (empProject1);
            empInProject=empProject;
            System.debug('final list'+empProject);
         // to get employee detail addr field removed
      //   Employee__c employee=[SELECT Employee__r.Id, Employee__r.Name, Employee__r.Department__c FROM EmployeeProject__c WHERE Project__r.Id =:Project.Id];            
        }           
    }   
 }

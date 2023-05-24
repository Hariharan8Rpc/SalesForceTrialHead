public with sharing  class ExtensionEmployeeController {
    public List<Project__c> projectsList { get; set; }
    public List<Project__c> projectsList1 { get; set; }
    public EmployeeProject SingleEmplist{get;set;}
    Public  List<EmployeeProject> empProject{get;set;}
    public Id EmployeeSearchId {get;set;}
    public Id editId {get;set;}
    public Project__c project{get;set;}
    
    public boolean flag{get;set;}
    public boolean flag1{get;set;}
    Public  List<EmployeeProject> empInProject{get;set;}
    //for add update existing project 
    
    public ExtensionEmployeeController() {
        Project__c  project1 = new Project__c();
        project = project1;
        getprojects();
        getEmployees();
        GetAllProjects();
        flag=false;
        flag1=false;
    }
    
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
                //  System.debug('null in  addr object'+addr);
            } else {
                //   System.debug('null in  addr object');
            }             
            empProject1.projects=GetEmployeesproject(emp1.Id);   		
            //  System.debug('Project '+empProject1.projects);
            empProject.add(empProject1);          
        } 
        //    System.debug('final obj'+empProject);
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
            //  Project__c project = empProject.Project__r;
            projectList.add(empProject.Project__r);
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
            //     System.debug('null in  addr object'+addr);
        } else {
            //   System.debug('null in  addr object');
        } 
        //   SingleEmplist1.addr=[Select id,name,city__c,state__c,Pincode__c from Address__c where Employee__r.Id=:EmployeeSearchId];
        SingleEmplist=SingleEmplist1;
        System.debug('Single EMp list'+SingleEmplist);
        
        //       system.debug('employee111111 id from the get projec t methid'+empId1+'org id '+empid);
    }
    
    public void GetAllProjects(){
        //  List<Project__c> projectList = new List<Project__c>();
        projectsList=[Select id,Name,Domain__c,Duration__c,Priority__c from Project__c];
    }
    
    public void getEmployeesRelatedToProject(){
        flag1=true;
        system.debug(EmployeeSearchId+'id  Project  id');        
        project=[select id, Name ,Domain__C,Duration__c,Priority__C from Project__C where id=:EmployeeSearchId];
        empProject = new List<EmployeeProject>();
        List<EmployeeProject__c> employees = [SELECT Employee__r.Id, Employee__r.Name, Employee__r.Department__c FROM EmployeeProject__c WHERE Project__r.Id =:EmployeeSearchId];            
        system.debug('employee in query result'+employees);
        for(EmployeeProject__c employeeProj :employees){ 
            EmployeeProject empProject1= new EmployeeProject();    
            //  System.debug('inside the for of emp related to the projecrt'+employeeProj.employee__r.Id);
            empProject1.employee=employeeProj.employee__r;
            System.debug('Employee name realted to the project'+employeeProj.employee__r);
            //Address__c addr=new Address__c();
            empProject1.addr=[Select id,name,city__c,state__c,Pincode__c from Address__c where Employee__r.Id=:empProject1.employee.Id];		             
            empProject.add (empProject1);
            empInProject=empProject;
            System.debug('final emp list related to project'+empProject);
        }           
    }
    //methods related to the add/edit Project
    public void getprojects() {
        Id editId = ApexPages.currentPage().getParameters().get('id');
        if(editId !=null){
        project=[select id, Name,Domain__c,Duration__c,Priority__c From project__c where id=:editId];
        }
        system.debug('project in edit'+project);
    }
    
    public pageReference addProject(){
        upsert project;
        String secondPageUrl = '/apex/EmployeeProjectList';
        PageReference projectList = new PageReference(secondPageUrl);
        projectList.setRedirect(true);
        return projectList;
    }
    //
    public PageReference redirectToEditPage() {        
        system.debug('id in else redirectpage'+editId );
        String secondPageUrl = '/apex/EmployeeEditPage?id=' + editId;
        PageReference editPage = new PageReference(secondPageUrl);
        editPage.setRedirect(true);
        return editPage;
    }
    
    public PageReference deleteRecords(){
        List<Address__c> address1;   
        address1=[select id,name, state__c, city__c, pincode__c from address__C where employee__r.id=:EmployeeSearchId];
        if (address1 != null && address1.size() > 0) {
            delete address1[0];
        } 
        delete EmployeeSearchId.getSobjectType().newSObject(EmployeeSearchId);
        String secondPageUrl = '/apex/EmployeesPage';
        PageReference empPage = new PageReference(secondPageUrl);
        empPage.setRedirect(true);
        return empPage;
    }
    
    public PageReference redirectToEditProjectPage() {        
        system.debug('id in else redirectpage  for project edit paeg redirect id'+EmployeeSearchId );
        String secondPageUrl = '/apex/AddProjectPage?id=' + EmployeeSearchId;
        PageReference editProjectPage = new PageReference(secondPageUrl);
        editProjectPage.setRedirect(true);
        return editProjectPage;
    }
    
     Public List<SelectOption> getAccountNames() {
        list<Employee__c> finalEmp= new list<Employee__c>();
        list<Employee__c> emplist= new list<Employee__c>();
         emplist=[Select id ,name from employee__c];
         System.debug('Ful emp List'+emplist);
         list<Employeeproject__C> empPro= new List<Employeeproject__C>();
         empPro=[select employee__r.id, employee__r.Name From EmployeeProject__c where EmployeeProject__c.Project__r.Id !=:project.id ] ;
		  System.debug('emp name dsnt contain this project'+empPro);
         for(EmployeeProject__c  emp: empPro){
             system.debug(emp.Employee__c);
         }
         
         
         
        List<SelectOption> accOptions= new List<SelectOption>();
        accOptions.add( new SelectOption('','--Select--'));
          
        for(EmployeeProject__c empProj : [select employee__r.id, employee__r.Name From EmployeeProject__c where EmployeeProject__c.Project__r.Id !=:project.id ] ) {
            accOptions.add(new SelectOption(empProj.employee__r.id,empProj.employee__r.Name));
        }
        return accOptions;
    }
    
    
}
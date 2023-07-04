public class EmployeeControllerLwc1 {
    @AuraEnabled
    public List<Project__c> projectsList { get; set; }
    @AuraEnabled
    public List<Project__c> projectsList1 { get; set; }
    @AuraEnabled
    public EmployeeProject SingleEmplist{get;set;}
    @AuraEnabled
    Public List<EmployeeProject> empProject{get;set;}
    @AuraEnabled
    public Id EmployeeSearchId {get;set;}
    @AuraEnabled
    public Id editId {get;set;}
    @AuraEnabled
    Public Id selectedEmpId{get;set;} 
    @AuraEnabled
    public Project__c project{get;set;}
    @AuraEnabled
    public boolean flag{get;set;}
    public boolean flag1{get;set;}
    @AuraEnabled
    Public List<EmployeeProject> empInProject{get;set;}  
    public EmployeeControllerLwc1() {
        system.debug(' constructor__call');
        Project__c  project1 = new Project__c();
        project = project1;
        // getprojects();
        // getEmployees();
        // GetAllProjects();
        flag=false;
        flag1=false;
    }
    
    public class EmployeeProject{
        @AuraEnabled
        public Employee__c employee { get; set; }
        @AuraEnabled
        public List<Project__c> projects { get; set; }
        @AuraEnabled
        public Address__c addr { get; set; }
        public EmployeeProject() {
          
          employee = new Employee__c();
           
         projects = new List<Project__c>();
        
           addr = new Address__c();
        }
    }   

    @AuraEnabled (cacheable=true)
    public static List<EmployeeProject>  getEmployees(){      
        system.debug('getEmployees__call');
        List<EmployeeProject> empProject = new List<EmployeeProject>();
        List<Employee__c> employees = [SELECT Id FROM Employee__c];
        for(Employee__c emp1 :employees){            
            EmployeeProject empProject1= new EmployeeProject();                       
            Employee__c employee = [SELECT id,Name,Department__c ,Address__r.Id,Address__r.Name,Address__r.City__c ,Address__r.State__c ,Address__r.Pincode__c From Employee__c where id=:emp1.Id];
       //   Employee__c employee = [SELECT id,Name,Department__c Address__r.Id,Address__r.Name,Address__r.State__c,Address__r.Department__c,Address__r.City__C,Address__r.Pincode__c From Employee__c where id=:emp1.Id];
            empProject1.employee=employee;    
                //   address is directly added with the related list no  need to use external query
            // List<Address__c> address;   
            // address = [SELECT Id, Name, City__c, State__c, Pincode__c FROM Address__c WHERE Employee__r.Id = :emp1.Id];
            // if (address != null && address.size() > 0) {
            //     Address__c addr = address[0];
            //     empProject1.addr=addr;
            // } else {
            // }             
            empProject1.projects=GetEmployeesproject(emp1.Id);   		            
            empProject.add(empProject1);          
        }  
        return  empProject;    
    } 
 @AuraEnabled (cacheable=true)
    public static   List<Project__c> GetEmployeesproject(Id emp1){ 
        system.debug('GetEmployeesproject__call__param '+emp1);
        List<Project__c> projectList = new List<Project__c>();
        List<EmployeeProject__c> employeeProjects = [
            SELECT Project__r.Id, Project__r.Name, Project__r.Domain__c, Project__r.Duration__c, Project__r.Priority__c
            FROM EmployeeProject__c
            WHERE Employee__r.Id = :emp1
        ];
        for (EmployeeProject__c empProject : employeeProjects) {         
            projectList.add(empProject.Project__r);
        }
        return projectList;
    }
    
//   to  get all project detail
    @AuraEnabled (cacheable=true)
    public static List<Project__c> GetAllProjects(){
        system.debug('__call');
        return [Select id,Name,Domain__c,Duration__c,Priority__c from Project__c];
    }

    @AuraEnabled (cacheable=true)
    public static EmployeeProject getProjectsRelatedToEmployee(Id EmployeeSearchId){
        system.debug('getProjectsRelatedToEmployee__call');
        // flag=true;
        // system.debug('flag value in page  after initiate '+flag);
        EmployeeProject SingleEmplist1= new EmployeeProject();
        SingleEmplist1.projects=GetEmployeesproject(EmployeeSearchId);
        SingleEmplist1.employee=[
            SELECT id,Name,Department__c 
            From Employee__c where id=:EmployeeSearchId
        ];
        List<Address__c> address;   
       //  address  =[SELECT address__r.id,address__r.name ,address__r.City__c,address__r.State__c,address__r.Pincode__c FROM employee__C WHERE Id =:EmployeeSearchId ];
      address = [SELECT Id, Name, City__c, State__c, Pincode__c FROM Address__c WHERE Employee__r.Id = :EmployeeSearchId];
        if (address != null && address.size() > 0) {
            Address__c addr = address[0];
            SingleEmplist1.addr=addr;
        } else {
        }   
        System.debug('Single EMp list'+SingleEmplist1);
        return  SingleEmplist1;
        // SingleEmplist=SingleEmplist1;
        // System.debug('Single EMp list'+SingleEmplist);
    }
    @AuraEnabled
    //  (cacheable=true)
    public static boolean getdeleteRecords(Id deleteId){
        boolean flag=false;
        system.debug('deleteRecords__call_return page ref to EmployeesPage');
         List<Address__c> address1;   
         address1=[select id,name, state__c, city__c, pincode__c from address__C where employee__r.id=:deleteId];
         if (address1 != null && address1.size() > 0) {
         delete address1;
         } 

          List<Employee__c> emp1=[Select id, name from Employee__c where id=:deleteId];
          System.debug('list sizee'+emp1.size());
          Database.DeleteResult[] drList = Database.delete(emp1, True);    
          for(Database.DeleteResult dr : drList) {
            if(dr.isSuccess()){
                System.debug('inside delrte if ');
                flag=true;
            }
          }
          if(flag == true){
            return true;
          }else{
            return  true;
          }

        // List<Employee__c> em = [Select Id,name from Employee__c where id=:deleteId];
        // if(em == null && em.size()<1){
        //     System.debug('after delete chcekc  if+'+em+'Exception  from the DElete controlll');
        //     return true;
        // }else{
        //     System.debug('after delete chcek else+'+em +'Exception  from the DElete controlll');
        //     return false;
        // }
    }



//     @AuraEnabled (cacheable=true)
//     public static void getEmployees1(){
//      //   Employee__c employee=[select id,name,department__c, address__r from Employee__c where id=:empId];   
//         system.debug('getEmployees__call');
//         empProject = new List<EmployeeProject>();
//         List<Employee__c> employees = [select id,name,department__c,Address__r.Name,Address__r.Pincode__c, Address__r.State__c,Address__r.City__C from Employee__c];
//         for(Employee__c emp1 :employees){            
//             EmployeeProject empProject1= new EmployeeProject();                        
//             empProject1.employee=emp1;            
//             List<Address__c> address;   
//              address =emp1.Address__r;
//             if (address != null && address.size() > 0) {
//                 empProject1.addr=address[0];
                
//               System.debug('addrwss in the   '+address);
//             } else {
//             }     
//             System.debug('in if block  of the  he t method'+emp1.Address__r=='');         
//             empProject1.projects=GetEmployeesproject(emp1.Id);   		            
//             empProject.add(empProject1);          
//         }       
//     }


//     // @AuraEnabled (cacheable=true)
//     public void getEmployeesRelatedToProject(){
//         System.debug('getEmployeesRelatedToProject__Call');
//         flag1=true;
//         system.debug(EmployeeSearchId+'id  Project  id');        
//         project=[select id, Name ,Domain__C,Duration__c,Priority__C from Project__C where id=:EmployeeSearchId];
//         empProject = new List<EmployeeProject>();
//         List<EmployeeProject__c> employees = [SELECT Employee__r.Id, Employee__r.Name, Employee__r.Department__c FROM EmployeeProject__c WHERE Project__r.Id =:EmployeeSearchId];                
//         for(EmployeeProject__c employeeProj :employees){ 
//             EmployeeProject empProject1= new EmployeeProject();    
//             empProject1.employee=employeeProj.employee__r;
//             List<Address__c> address;   
//             address = [SELECT Id, Name, City__c, State__c, Pincode__c FROM Address__c WHERE Employee__r.Id = :empProject1.employee.Id];		
//             if (address != null && address.size() > 0) {
//                 empProject1.addr = address[0];
//                 SingleEmplist1.addr=addr;
//             }

//          //   empProject1.addr=[Select id,name,city__c,state__c,Pincode__c from Address__c where Employee__r.Id=:empProject1.employee.Id];		             
//            empProject.add (empProject1);
//             empInProject=empProject;
//             System.debug('final emp list related to project on view  button  click '+empProject);
//             getEmployeeNames();
        
//         }                                                                           
// }                                                                   
// //   @AuraEnabled (cacheable=true)
//     public void getprojects() {
//         system.debug('getprojects__call');
//         Id editId = ApexPages.currentPage().getParameters().get('id');
//         if(editId !=null){
//             project=[select id, Name,Domain__c,Duration__c,Priority__c From project__c where id=:editId];
//         }                                                                               
//         system.debug('project in edit'+project);                                                
//     }
    
//     public pageReference addProject(){
//         system.debug('addProject__call__return__pagerefTo__EmployeeProjectList');
//         upsert project;
//         String secondPageUrl = '/apex/EmployeeProjectList';
//         PageReference projectList = new PageReference(secondPageUrl);
//         projectList.setRedirect(true);
//         return projectList;
//     }
//     //
//     public PageReference redirectToEditPage() {  
//         system.debug('redirectToEditPage__call__returnPagerefTo_EmployeeEditPage');
//         system.debug('id in else redirectpage'+editId );
//         String secondPageUrl = '/apex/EmployeeEditPage?id=' + editId;
//         PageReference editPage = new PageReference(secondPageUrl);
//         editPage.setRedirect(true);
//         return editPage;
//     }
    

    
//     public PageReference redirectToEditProjectPage() {  
//         system.debug('redirectToEditProjectPage__call return pagerefTo EmployeeSearchId');
//         system.debug('id in else redirectpage  for project edit paeg redirect id'+EmployeeSearchId );
//         String secondPageUrl = '/apex/AddProjectPage?id=' + EmployeeSearchId;
//         PageReference editProjectPage = new PageReference(secondPageUrl);
//         editProjectPage.setRedirect(true);
//         return editProjectPage;
//     }
//     // @AuraEnabled (cacheable=true)
//     Public List<SelectOption> getEmployeeNames() {
//         system.debug('getEmployeeNames__call return list option picklist');
//         //  list<Employee__c> finalEmp= new list<Employee__c>();
//         list<Employee__c> emplist= new list<Employee__c>();
//         emplist=[Select id ,name from employee__c];
//         System.debug('Ful emp List'+emplist);
//         list<Employeeproject__C> empPro= new List<Employeeproject__C>();
//         empPro=[select employee__r.id, employee__r.Name From EmployeeProject__c where EmployeeProject__c.Project__r.Id =:project.id ];
//         System.debug('emp name dsnt contain this project'+empPro);
//         Map<String,String> finalempmap = new Map<String,String> ();
//         Map<String,String> finalempmap1 = new Map<String,String> ();
//         for(EmployeeProject__c  emp: empPro){
//             finalempmap.put(emp.employee__r.id,emp.employee__r.name);
//         }
        
//         for(Employee__c em:emplist){
//             for(String empid:finalempmap.keyset()){
//                 if(em.id !=empid){
//                     finalempmap1.put(em.id,em.name);                  
//                 }else{
//                     system.debug('exist'+em.id);
//                 }
//             }
//         }
        
//         System.debug('final emp map1 ; '+finalempmap1);  
//         List<SelectOption> accOptions= new List<SelectOption>();
//         if(finalempmap1.size()>0){
//             ///adding to pick list
//             system.debug('inside if picklist');
//             accOptions.add( new SelectOption('','--Select--'));
//             for(String ids:finalempmap1.keySet()){
//                 accOptions.add(new SelectOption(ids,finalempmap1.get(ids)));
//             } 
//             return accOptions;
//         }else{
//             system.debug('inside else picklist');
//             accOptions.add( new SelectOption('','--Select--'));
//             for(Employee__c  emp:emplist){
//                 accOptions.add(new SelectOption(emp.Id,emp.Name));
//             } 
//             return accOptions;
//         }
//     }
//     // @AuraEnabled (cacheable=true)
//     public Void addEmployeeToProject(){
//         system.debug('addEmployeeToProject__call');
//         EmployeeProject__c empPro = new EmployeeProject__c();
//         empPro.name=Project.Name+'emp'+selectedEmpId;
//         empPro.Employee__c=selectedEmpId;
//         empPro.Project__c=project.id;
//        // insert empPro;
//           Database.insert (empPro,false);
       
//        getEmployeesRelatedToProject();
//         getEmployeeNames();
//         System.debug('employee addded to the project '+empPro);
//         //selectedEmpId   project.id
//     }
    
//     public pageReference deleteProject(){
//         system.debug('deleteProject__call  return page ref to EmployeeProjectList ');
//         list<EmployeeProject__c> empPro = new list<EmployeeProject__c>();
//         empPro=[select id,name from EmployeeProject__c where project__r.id=:EmployeeSearchId];
//         system.debug('employee in project deleted ; '+empPro);
//         System.debug(Database.delete(empPro));
//         delete [select Id, name from project__c where id=:EmployeeSearchId];        
//         String secondPageUrl = '/apex/EmployeeProjectList';
//         PageReference projectListPage = new PageReference(secondPageUrl);
//         projectListPage.setRedirect(true);
//         return projectListPage;
//     }
    
//     public void deleteEmployeeFromProject(){
//         system.debug('deleteEmployeeFromProject__call');
//         delete [select id,name from employeeProject__c where employee__r.id=:editId];
//         getEmployeesRelatedToProject();
//         getEmployeeNames();
//     }
}

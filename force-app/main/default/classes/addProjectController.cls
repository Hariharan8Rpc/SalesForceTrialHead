public class addProjectController {
	  public Project__c project{get;set;}
    
    public addProjectController(){
         Project__c  project1 = new Project__c();
         project = project1;
} 
    
    public void getprojects(){
         Id editId = ApexPages.currentPage().getParameters().get('id');
		project=[select id, Name From project__c where id=:editId];
        system.debug('project in edit'+project);
    }
   
    public pageReference addProject(){
		upsert project;
          String secondPageUrl = '/apex/EmployeeProjectList';
              PageReference projectList = new PageReference(secondPageUrl);
              projectList.setRedirect(true);
        return projectList;
    }
}
public class addProjectController {
	  public Project__c project{get;set;}
    
    public addProjectController(){
         Project__c  project1 = new Project__c();
   project = project1;
}
   
    public pageReference addProject(){
		insert project;
          String secondPageUrl = '/apex/EmployeeProjectList';
              PageReference projectList = new PageReference(secondPageUrl);
              projectList.setRedirect(true);
        return projectList;
    }
}
public virtual with sharing class employeeExtenisonEditController {
    private EXtensionEmployeeController mainController;

    public employeeExtenisonEditController() {
        mainController = new EXtensionEmployeeController();
    }
    
    public Employee__c employee{get;set;}
    public Id editId{get;set;}
    public void  editEmployee(){
        System.debug('Id to edit'+editId);
    }

}
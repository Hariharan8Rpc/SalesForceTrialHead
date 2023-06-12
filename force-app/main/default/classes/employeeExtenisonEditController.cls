public  class employeeExtenisonEditController {
    public Employee__c employee{get;set;}
    public Id editId{get;set;}
    public address__C address{get;set;}
    
    public employeeExtenisonEditController(){
        System.debug('Id in constructor '+editId);
        editId = ApexPages.currentPage().getParameters().get('id');
        if(editId!=null){
        System.debug('Id to edit' +editId);
        employee=[select id,name,department__c,(select id,name,state__C,city__C,pincode__c from address__r) from Employee__c where id=:editId];
        //address=[select id,name, state__c, city__c, pincode__c from address__C where employee__r.id=:editId];
    
        List<Address__c> address1;   
        address1=[select id,name, state__c, city__c, pincode__c from address__C where employee__r.id=:editId];               
        if (address1 != null && address1.size() > 0) {
            address = address1[0];
        } else {
            Address__c  address2 = new Address__c();
            address2.Employee__c=employee.Id;
            address=address2;
            system.debug('No Address related to this employee');
        } 
        }else{
          employee = new Employee__c();
           address = new Address__c(); 
        }
    }
    
    public pageReference save(){
        // employee.Address__c=address;
        upsert employee;
        system.debug('log'+address==null);  
        address.Employee__c=employee.id;
        upsert address;
        String secondPageUrl = '/apex/EmployeesPage';
        PageReference editPage = new PageReference(secondPageUrl);
        editPage.setRedirect(true);
        return editPage;
    }
}   
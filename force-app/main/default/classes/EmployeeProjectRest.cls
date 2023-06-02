@RestResource(urlMapping='/EmployeeProject/*')

// /services/apexrest/EmployeeProject/0012w00001PVxp1AAD    end point url


global with sharing class EmployeeProjectRest {
    @HttpDelete
    global static void doDelete() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String empId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Employee__c  emp = [SELECT Id FROM Employee__c WHERE Id = :empId];
        delete emp;
    }
  
    @HttpGet
    global static Employee__c doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String empId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
     Employee__c em=[select id,name,department__c,(select id,name,state__C,city__C,pincode__c from address__r) from Employee__c where id=:empId];    
        return em;
    }
  
  @HttpPost
    global static String doPost(String Name,
        String Department,String addrName,String City,String State, Integer Pincode) {
            System.debug('in the post menthod'+Name+ ' '+Department );
        /*     json body 
        {
        "Name" : "demo with addr",
        "Department" : "ceses",
        "addrName" :"trial",
        "City":"manglore",
        "Pincode":574747,
        "State":"maglore"
        }
        */
        Address__c addr =new Address__c();
        addr.Name=addrName;
        addr.City__c=City;
        addr.Pincode__c=Pincode;
        addr.State__c=State;
        insert addr;
        System.debug( 'Addr in the rest'+addr); 
        Employee__c em = new Employee__c(); 
        em.Name = name;
        em.Department__c=Department;
        em.Address__c=addr.Id;
        insert em;
        return em.Id;
    }
// update 
 @HttpPut
    global static String doPut(String Name,
        String Department,String addrName,String City,String State, Integer Pincode) {
            System.debug('in the post menthod'+Name+ ' '+Department );
        /*     json body 
        {
        "Name" : "demo with addr",
        "Department" : "ceses",
        "addrName" :"trial",
        "City":"manglore",
        "Pincode":574747,
        "State":"maglore"
        }
        */
        Address__c addr =new Address__c();
        addr.Name=addrName;
        addr.City__c=City;
        addr.Pincode__c=Pincode;
        addr.State__c=State;
        upsert addr;
        System.debug( 'Addr in the rest'+addr); 
        Employee__c em = new Employee__c(); 
        em.Name = name;
        em.Department__c=Department;
        em.Address__c=addr.Id;
        upsert em;
        return em.Id;
    }
}
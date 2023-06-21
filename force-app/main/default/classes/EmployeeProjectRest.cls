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
        return em.id;
    }
// update 
 @HttpPut
    global static Employee__c  doPut(String Name,
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
        List<Address__c> address1;   
      //  String query1=('select id,name, state__c, city__c, pincode__c from address__C where Name=:addrName');
        //Database.query(query1);
        address1=[select id,name, state__c, city__c, pincode__c from address__C where Name=:addrName limit 1];
        System.debug('condition of addr +'+address1 != null && address1.size() > 0 );
        System.debug('condition other'+ !address1.isEmpty());
        if (!address1.isEmpty()) {        
        address1[0].Name=addrName;
        address1[0].City__c=City;
        address1[0].Pincode__c=Pincode;
        address1[0].State__c=State;
            System.debug('address1[0] in if'+address1[0]);
        upsert address1[0];
          System.debug('inside address debug updaet block in if');
        } else{
        System.debug('new address  in else block');        
        addr.Name=addrName;
        addr.city__c=City;
        addr.Pincode__c=Pincode;
        addr.State__c=State;
        address1.add(addr);
        System.debug('address1[0] in else'+address1[0]);
        upsert address1[0];
        }

        Employee__c em = new Employee__c(); 
        List<Employee__c> emp =[Select id, NAME, Department__c from Employee__c where Name=:name];
        System.debug('condition of emp'+emp != null && emp.size() > 0);
        if (emp != null && emp.size() > 0) {
        emp[0].Name = name;
        emp[0].Department__c=Department;
        emp[0].Address__c=address1[0].Id;
        upsert  emp[0];
        return  emp[0];
        }else{
        //    Employee__c em = new Employee__c(); 
            em.Name = name;
            em.Department__c=Department;
            em.Address__c=address1[0].Id;            
            upsert em;
            return  em;
        }
       
    }
}
public with sharing class SerializeExample {
    public void getPostal(){
        String jsonInput=('{\n' +
        ' "description" : "An appliance"\n'+'}');
        Http http=new Http();
        Map<String,Object>  m1 = (Map<String,Object>)JSON.deserializeUntyped(jsonInput);
        
        for(String ids:m1.keySet()){
            System.debug('op mock'+m1.get(ids));
        }

        String jsonString = JSON.serialize([SELECT Id, Name from Employee__c]);
        System.debug(jsonString);
      
        String url='https://api.postalpincode.in/pincode/'+'571201';
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');
        HttpResponse res = http.send(req);

        if(res.getstatusCode() == 200 && res.getbody() != null){
        //    System.debug('body'+res.getBody());         
        //  Map<String,map Object> m = (Map<String, Object>)JSON.deserializeUntyped(res.getbody());
        //  System.debug('response deserialize' + m);
}
    }
    public SerializeExample() {
   //     getPostal();
}
}
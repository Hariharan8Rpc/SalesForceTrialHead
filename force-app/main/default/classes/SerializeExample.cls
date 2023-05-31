public with sharing class SerializeExample {
    public void getPostal(){
        String jsonInput=('{\n' +
        ' "description" : "An appliance"\n'+'}');
        Http http=new Http();
        Map<String, Object> m1 = (Map<String, Object>)JSON.deserializeUntyped(jsonInput);
        System.debug('op mock'+m1);
        String url='https://api.postalpincode.in/pincode/'+'571201';
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');
        HttpResponse res = http.send(req);

        if(res.getstatusCode() == 200 && res.getbody() != null){
            System.debug('body'+res.getBody());
            // postOffices=(PostOffice)json.deserialize(res.getbody(),(PostOffice).class); 
            // Map<String,cls_PostOffice1> results1 = (Map<String,cls_PostOffice1>)JSON.deserialize(res);
            // map=(Map<String,cls_PostOffice1>)json.deserialize(res.getbody(),Map<String,cls_PostOffice1>.class); 
            Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(res.getbody());
        
            // postOffices=(List<cls_PostOffice1>)json.deserialize(res.getbody(),List<cls_PostOffice1>.class);
         System.debug('response deserialize' + m);
}
    }

    public SerializeExample() {
        getPostal();
}
}
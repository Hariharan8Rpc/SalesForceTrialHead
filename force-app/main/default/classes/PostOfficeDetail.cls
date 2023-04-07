global class PostOfficeDetail {
   
    @AuraEnabled
    global  List<cls_PostOffice1> getPostOficeInfo() {
        List<cls_PostOffice1> postOffices= new List<cls_PostOffice1>();        
        Http http=new Http();
        String url='https://api.postalpincode.in/pincode/571201';
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');
        HttpResponse res = http.send(req);

        if(res.getstatusCode() == 200 && res.getbody() != null){
              postOffices=(List<cls_PostOffice1>)json.deserialize(res.getbody(),List<cls_PostOffice1>.class);
            }
         System.debug(postOffices);
        for(cls_PostOffice1 s:postOffices){
            
            System.debug(s.PostOffice);
         System.debug(s.PostOffice.size());     					
        }

    return postOffices;
    }
}
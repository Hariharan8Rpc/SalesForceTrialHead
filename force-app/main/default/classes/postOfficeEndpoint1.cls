public class postOfficeEndpoint1 {
    
    Integer postalCode=574142;
public static Map<String,Object> getPostOficeInfo(Integer postalCode) {
            Map<String,Object> postOffices = new Map<String,Object>();
            // Map<String,cls_PostOffice1> map = new Map<String,cls_PostOffice1>();
            Http http=new Http();
            String addr=String.ValueOf(postalCode);
           
            String url='https://api.postalpincode.in/pincode/'+addr;
            HttpRequest  req= new HttpRequest();
            req.setEndpoint(url);
            req.setMethod('GET');
            HttpResponse res = http.send(req);
            if(res.getstatusCode() == 200 && res.getbody() != null){
                
                   postOffices = (Map<String, Object>)JSON.deserializeUntyped(res.getbody());  
                // postOffices=Map<String,Object>json.deserialize(res.getbody(),Map<String,Object>);     
            //   Map<String, Object> deserialized = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
             //   List<Map<String, Object>> data = new List<Map<String, Object>>();
              //  for (Object instance : (List<Object>)deserialized.get('data'))
               //     data.add((Map<String, Object>)instance);
              //     System.debug(data);
              }
           System.debug(postOffices);
          return postOffices; 
  }
}
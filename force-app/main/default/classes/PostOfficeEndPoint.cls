global class PostOfficeEndPoint {
    // https://api.postalpincode.in/pincode/571201   

       global class cls_PostOffice1 {
            @AuraEnabled
            public String Message;
           @AuraEnabled
            public String Status;	//Success
        //  public cls_PostOffice[] PostOffice;
           @AuraEnabled
             public List<Cls_PostOffice> PostOffice = new List<Cls_PostOffice>();
        }

      global  class cls_PostOffice {
          @AuraEnabled
            public String Name;	
            // public cls_Description Descriptio n;
            public String BranchType;	
            public String DeliveryStatus;
          @AuraEnabled
            public String Circle;	
          @AuraEnabled
            public String District;
            public String Division;	//Kodagu
            public String Region;	//South Karnataka
          @AuraEnabled  
            public String Block;
          @AuraEnabled
            public String State;
          @AuraEnabled
            public String Country;
          @AuraEnabled
            public String Pincode;	//571201
        }

		@AuraEnabled (cacheable=true)
        public static List<cls_PostOffice1> getPostOficeInfo(Integer postalCode) {
            List<cls_PostOffice1> postOffices = new List<cls_PostOffice1>();
            // Map<String,cls_PostOffice1> map = new Map<String,cls_PostOffice1>();
            Http http=new Http();
            String addr=String.ValueOf(postalCode);
           
            String url='https://api.postalpincode.in/pincode/'+addr;
            HttpRequest req = new HttpRequest();
            req.setEndpoint(url);
            req.setMethod('GET');
            HttpResponse res = http.send(req);
    
            if(res.getstatusCode() == 200 && res.getbody() != null){
                // postOffices=(PostOffice)json.deserialize(res.getbody(),(PostOffice).class); 
                // Map<String,cls_PostOffice1> results1 = (Map<String,cls_PostOffice1>)JSON.deserialize(res);
                // map=(Map<String,cls_PostOffice1>)json.deserialize(res.getbody(),Map<String,cls_PostOffice1>.class); 
               postOffices=(List<cls_PostOffice1>)json.deserialize(res.getbody(),List<cls_PostOffice1>.class);
               System.debug(postOffices);
              //  cls_PostOffice1 result = (cls_PostOffice1) JSON.deserialize(res.getBody(), cls_PostOffice1.class);
              // system.debug(result);
              }
           System.debug(postOffices);
            // for(cls_PostOffice1 s:postOffices){ 
            //     System.debug(s.PostOffice);
            //  System.debug(s.PostOffice.size());     					
            // }
          return postOffices; 
  }
}

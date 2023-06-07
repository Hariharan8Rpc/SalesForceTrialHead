global class PostOfficeEndPoint {
    // https://api.postalpincode.in/pincode/571201   

    public static Integer postalCode{get;set;}
    
    public static List<PostOfficeEndPoint.cls_PostOffice1> PostOffice {get;set;}    
       global class cls_PostOffice1 {
            @AuraEnabled
            public String Message { get; set; }
           @AuraEnabled
            public String Status{ get; set; }	//Success
        //  public cls_PostOffice[] PostOffice;
           @AuraEnabled
           public List<cls_PostOffice> PostOffice {get;set;}    

           //  public List<Cls_PostOffice> PostOffice = new List<Cls_PostOffice>();
        }

      global  class cls_PostOffice {
          @AuraEnabled
            public String Name{ get; set; }
            // public cls_Description Descriptio n;
            public String BranchType{ get; set; }
            public String DeliveryStatus{ get; set; }
          @AuraEnabled
            public String Circle{ get; set; }	
          @AuraEnabled
            public String District{ get; set; }
            public String Division{ get; set; }	//Kodagu
            public String Region{ get; set; }	//South Karnataka
          @AuraEnabled  
            public String Block{ get; set; }
          @AuraEnabled
            public String State{ get; set; }
          @AuraEnabled
            public String Country{ get; set; }
          @AuraEnabled
            public String Pincode{ get; set; }	//571201
        }

        public static void getPostOfficeInfo(){
          System.debug('inside controller calll');
          //  PostOfficeEndPoint endPoint = new PostOfficeEndPoint();
          PostOffice = getPostOficeInfo(postalCode);
          system.debug('----p0stal---'+PostOffice);
      }


		@AuraEnabled (cacheable=true)
        public static List<cls_PostOffice1> getPostOficeInfo(Integer postalCode) {
            List<cls_PostOffice1> postOffices = new List<cls_PostOffice1>();
            // Map<String,cls_PostOffice1> map = new Map<String,cls_PostOffice1>();
            Http http=new Http();
            String addr=String.ValueOf(postalCode);
            postOfficeMetadata__mdt metaurl = postOfficeMetadata__mdt.getInstance('post');
            System.debug('metadaTA'+metaurl);
            // String url='https://api.postalpincode.in/pincode/'+addr;
            String url=metaurl.url__c+addr;
            HttpRequest req = new HttpRequest();
            req.setEndpoint(url);
            req.setMethod('GET');
            HttpResponse res = http.send(req);
    
            if(res.getstatusCode() == 200 && res.getbody() != null){
                // postOffices=(PostOffice)json.deserialize(res.getbody(),(PostOffice).class); 
                // Map<String,cls_PostOffice1> results1 = (Map<String,cls_PostOffice1>)JSON.deserialize(res);
                // map=(Map<String,cls_PostOffice1>)json.deserialize(res.getbody(),Map<String,cls_PostOffice1>.class); 
               postOffices=(List<cls_PostOffice1>)json.deserialize(res.getbody(),List<cls_PostOffice1>.class);
             
              //  PostOffice=postOffices;
                 System.debug(postOffices);
              //  cls_PostOffice1 result = (cls_PostOffice1) JSON.deserialize(res.getBody(), cls_PostOffice1.class);
              // system.debug(result);
              }
        //   System.debug(postOffices);
            // for(cls_PostOffice1 s:postOffices){ 
            //     System.debug(s.PostOffice);
            //  System.debug(s.PostOffice.size());     					
            // }
          return postOffices; 
  }
}
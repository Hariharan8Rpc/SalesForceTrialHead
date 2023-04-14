public with sharing class PostalController {
    public PostalController() {
    }
    @AuraEnabled
         public String Name { get; set; }
        public String Description { get; set; }
        public String BranchType { get; set; }
        public String DeliveryStatus { get; set; }
        public String Circle { get; set; }
        public String District { get; set; }
        public String Division { get; set; }
        public String Region { get; set; }
        public String State { get; set; }
        public String Country { get; set; }
        public String Pincode { get; set; }
        
    public static Integer postalCode{get;set;}
    @AuraEnabled
    public static List<PostOfficeEndPoint.cls_PostOffice1> PostOffice {get;set;}    

    @AuraEnabled(cacheable=true)
    public static void getPostOfficeInfo(){
        System.debug('inside controller calll');
        //  PostOfficeEndPoint endPoint = new PostOfficeEndPoint();
        PostOffice = PostOfficeEndPoint.getPostOficeInfo(postalCode);
        system.debug('----p0stal---'+PostOffice);
    }
}
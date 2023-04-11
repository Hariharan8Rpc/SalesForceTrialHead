public with sharing class PostalController {
    public PostalController() {
    }
    @AuraEnabled
    public static Integer postalCode{get;set;}
    @AuraEnabled
    public static List<PostOfficeEndPoint.cls_PostOffice1> PostOffice {get;set;}    

    @AuraEnabled(cacheable=true)
    public static void getPostOfficeInfo(){
        System.debug('inside controller calll');
         PostOfficeEndPoint endPoint = new PostOfficeEndPoint();
        PostOffice = endPoint.getPostOficeInfo(postalCode);
        
        system.debug('----p0stal---'+PostOffice);
    }
}
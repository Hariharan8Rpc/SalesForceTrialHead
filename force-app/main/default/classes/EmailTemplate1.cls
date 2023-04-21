public with sharing class EmailTemplate1 {    
   @AuraEnabled
    public static string sendEmail(String contId  ,String email,String bccAddress,String ccAddress, String Subject, String Message){
        System.debug('inside the mail method'+email+ subject);

        String sMessage='';
        try{
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {email}; 
            String[] bccAddresses = new String[] {bccAddress}; 
            String[] ccAddresses = new String[] {ccAddress}; 
            // template id  of the template so it can be populated in the template
          //  Id templateId='00X2w000000OAmlEAG';
            Id whatid1=contId;
          String  templateName='Demo2';
            //Classic eMail Template
            Id templateId = [SELECT Id FROM EmailTemplate WHERE Name = :templateName AND IsActive = true].Id;
            system.debug('inside the classs id    '+templateId);

            String body = Messaging.renderStoredEmailTemplate(templateId, null, null).getPlainTextBody();
             System.debug('Templaete if from the classs  '+templateId);
             body=body+Message;
            mail.setHtmlBody(body);
            // end to set the classic email template to the mail 
            mail.setToAddresses(toAddresses);
            mail.setSubject(Subject);
           // mail.setHtmlBody(Message);
            mail.setCcAddresses(ccAddresses);
            mail.setBccAddresses(bccAddresses);
         //   mail.setTemplateId( templateId);
           // mail.setWhatId(whatid1);         
            Messaging.SendEmailResult [] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
            sMessage='Success';
        }
        catch(Exception ex){
            sMessage=ex.getLineNumber()+'\n'+ex.getCause()+'\n'+ex.getMessage()+'\n'+ex.getStackTraceString();
        }
        return sMessage;
    }
    
    @AuraEnabled
	public static Contact getContactRecord(String currentRecordId) {
        Contact contact = [select id,Email,name FROM Contact where id =: currentRecordId ];
       System.debug('contact id  '+currentRecordId); 
        return contact;
           }   
           
    @AuraEnabled(cacheable=true)
    public static String getUserEmail() {
        return UserInfo.getUserEmail();
    }
    
}
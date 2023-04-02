public with sharing class EmailTemplate1 {    
   @AuraEnabled
    public static string sendEmail(String email, String Subject, String Message){
        System.debug('inside the mail method'+email+ subject);
        String sMessage='';
        try{
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {email}; 
            mail.setToAddresses(toAddresses);
            mail.setSubject(Subject);
            mail.setHtmlBody(Message);
            
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
}
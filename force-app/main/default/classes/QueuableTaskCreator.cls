public with sharing class QueuableTaskCreator  implements Queueable{
    private String recId;
    // QueuableTaskCreator qjob= new QueuableTaskCreator(acc.Id); 
    // To call the method pass the record ifd with id
 List<Contact> contacts =new List<Contact>();
    
    public QueuableTaskCreator(String recId) {
        this .recId=recId;
        }
        
        public void execute(QueueableContext context){
            Task tsk=new Task();
            tsk.Subject='Creating from Queuable';
            tsk.WhatId=recId; 
            insert tsk;
            for (Integer i = 0; i < 500; i++) {
                Contact con=new Contact(LastName='test'+' - '+string.valueOf(i),AccountId =recId);
                contacts.add(con);
            }
            insert contacts;
        }
}
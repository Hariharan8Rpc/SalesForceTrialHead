public with sharing class QueuableTaskCreator  implements Queueable{
    private String recId;
    public QueuableTaskCreator(String recId) {
        this .recId=recId;
        }
        public void execute(QueueableContext context){
            Task tsk=new Task();
            tsk.Subject='Creating from Queuable';
            tsk.WhatId=recId; 
            insert tsk;
        }
}
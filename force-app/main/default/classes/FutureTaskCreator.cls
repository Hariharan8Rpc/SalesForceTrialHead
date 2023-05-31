public with sharing class FutureTaskCreator {
    @future(callout=true)
    public Static void createTask(String recId) {
Task tsk=new Task();

tsk.Subject='Crating from future';
tsk.WhatId=recId;
insert tsk;
}
}
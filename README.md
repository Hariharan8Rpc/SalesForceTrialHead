# Salesforce DX Project: Next Steps

Now that you’ve created a Salesforce DX project, what’s next? Here are some documentation resources to get you started.

## How Do You Plan to Deploy Your Changes?

Do you want to deploy a set of changes, or create a self-contained application? Choose a [development model](https://developer.salesforce.com/tools/vscode/en/user-guide/development-models).

## Configure Your Salesforce DX Project


The `sfdx-project.json` file contains useful configuration information for your project. See [Salesforce DX Project Configuration](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ws_config.htm) in the _Salesforce DX Developer Guide_ for details about this file.

## Read All About It

- [Salesforce Extensions Documentation](https://developer.salesforce.com/tools/vscode/)
- [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)

###  NOTES FOR Understanding

## What is rendered Attribute?
 It is a Boolean value weather the component is rendered on visualforce page.
 If it is not specified, default value is always true.
 

## What is reRender Attribute?
 This attribute is useful to render some other visualforce component based Boolean value.

## Syntax
<apex:inputField value="{!V1.Insured_Amount__c}" rendered="{!V1.Is_insured__c==true}"/>



### A Wrapper Class
in simple terms, is an object created in Apex – similar to a custom,object but created in code.
 This data lives only in code during your transaction and does not consume database storage.

### trigger_events 
before insert
before update
before delete
after insert
after update
after delete
after undelete

### Syntax
trigger TriggerName on ObjectName (trigger_events) {
                     code_block
                     
                     }


The following table lists considerations about certain actions in different trigger events:

|Trigger Event |	Can change fields using trigger.new | Can update original object using an update DML operation | Can delete original object using a delete DML operation |
| --- | --- | --- | --- |
|before insert | Allowed |  Not applicable | Not applicable. |
| after insert | Not allowed| Not allowed. | Allowed |
| before update | Allowed. |  Not allowed. 	|	Not allowed.|
| after update	| Not allowed.	|	  Allowed. 	|	 Not allowed. |
| before delete	| Not allowed. 	|	  Allowed. 	|	   Not allowed. |
| after delete	| Not allowed.	|	  Not allowed.   |   Not applicable. | 
| after undelete | Not allowed.	|	  Allowed.	|	  Allowed. |


### Overriding the classes
- Methods and classes are final by default.
- The virtual definition modifier allows extension and overrides.
- The override keyword must be used explicitly on methods that override base class methods.




### Lightning Web Components decorators include
## @api: 
Marks a field as public. Public properties define the API for a component.
 An owner component that uses the component in its HTML markup can access the component's public properties.

## @track:
 Tells the framework to observe changes to the properties of an object or to the elements of an array.
 If a change occurs, the framework rerenders the component. All fields are reactive. 
Use @track only if a field contains an object or an array and if you want the framework to observe changes to the properties of the object or to the elements of the array.
 If you want to change the value of the whole property, you don't need to use @track.

## @wire:
 Gives you an easy way to get and bind data from a Salesforce org.

### Future Methods
- A future method runs in the background, asynchronously. You can call a future method for executing long-running operations,
- such as callouts to external Web services or any operation you’d like to run in its own thread, on its own time. 
-  Methods with the future annotation must be static methods, and can only return a void type.
- Methods with the future annotation can’t take sObjects or objects as arguments.
- use the ID to perform a query for the most up-to-date record
- Call async from triggers, etc, where callouts are not permitted.
- allouts enable Apex to invoke external web or HTTP services. Apex Web services allow an external application to invoke Apex methods through Web services
- Future methods can’t be used in Visualforce controllers in getMethodName(), setMethodName(), nor in the constructor.
- refer FutureTaskCreator.cls  for eg
### BAtch 
- if you specify Database.Stateful in the class definition, you can maintain state across these transactions.
- When using Database.Stateful, only instance member variables retain their values between transactions.
- Static member variables don’t retain their values and are reset between transactions
- If you don’t specify Database.Stateful, all static and instance member variables are set back to their original values.
- By default the batch scope will be 200
- Max scope is
# To execute bacth job in ananonymous window
  ```  java 
  ProcessAccounts bjob =new  ProcessAccounts();
    database.executeBatch(bjob);   //2000
  ```
## implements Database.Batchable<> 
- Refer ProcessAcccounts.cls   for eg
##Example
``` java
public class BatchClass implements Database.Batchable<Account>{
   public Iterable<Account> start(Database.BatchableContext info){
       return new CustomIterable();
   }
   public void execute(Database.BatchableContext info, List<Account> scope){
       List<Account> accsToUpdate = new List<Account>();
       for(Account acc : scope){
           acc.Name = 'changed';
           acc.NumberOfEmployees = 69;
           accsToUpdate.add(acc);
       }
       update accsToUpdate;
   }
   public void finish(Database.BatchableContext info){
   }
}
```
## to test batch class call batch with the 
 DataBase.executeBatch(objname  of the batch); 

Example LeadProcess

###Queueable Apex

# Queueable Apex is essentially a superset of future methods- 
- a simplified interface without start and finish methods and even allows you to utilize more than just primitive arguments!
- System.enqueueJob() method, which returns a job ID that you can monitor.
- Syntax
[Queueable Example]
- Refer QueuableTaskCreator.cls    
``` java
// QueuableTaskCreator qjob= new QueuableTaskCreator(acc.Id);
// To cla  the quequabel method pass the id of the record with it 
public class SomeClass implements Queueable {
    public void execute(QueueableContext context) {
        // awesome code here
    }
}
```
### scheduleable apex
The Apex Scheduler lets you delay execution so that you can run Apex classes at a specified time. 

// Seconds Minutes Hours Day_of_month Month Day_of_week optional_year
``` java 
String sch = '20 30 8 10 2 ?';
String jobID = System.schedule('Comments for the schedule', 'time', schedulabele that  has to be performed);

public class SomeClass implements Schedulable {
    public void execute(SchedulableContext ctx) {
        // awesome code here
    }
}
```
### Apex callouts
  SOAP -> xml
  REST-> JSON

## generate apex classes from wsdl

enter apex classes in quick find box-> apex classes-> click generate From wsdl
 choose file to upload -> click Parse wsdl.

### Apex Webervices
(server api end points 
)

### REST
Base end point  @RestResource(urlMapping='/Account/*').
### http Methods

## method visiblity should be global static
#Annotation	Action	Details
| Method | description |
| --- | --- |
| @HttpGet |	Read	Reads or retrieves records |
|@HttpPost |	Create	Creates records|
|@HttpDelete |	Delete	Deletes records |
|@HttpPut |	Upsert	Typically used to update existing records or create records |
|@HttpPatch |	Update	Typically used to update fields in existing records |


## example
``` java
@RestResource(urlMapping='/Account/*')
global with sharing class MyRestResource {
    @HttpGet
    global static Account getRecord() {
        // Add your code
    }
}
```
## Rest With  Put 
``` java
@HttpPut
global static ID upsertCase(){
//body
return id;
}
```
### SOAP
Define your class as global. Add the webservice keyword and the static definition modifier to each method you want to expose.                                                                                                     

## Example 
``` java
global with sharing class MySOAPWebService {
    webservice static Account getRecord(String id) {
        // Add your code
    }
}
```
### Iterators & Iterable

While

Custom iterator class must implements iterators interface

methods : hasNext, next
hasNext :returns true if the collectoin has next item in it
next: returns the next item in collection


### Platform Api's

REST 
SOAP
Streaming APi's
Bulk Api's

### Lwc 
### modules  building lightning web component

@wire Read data 
@api
 '$field name'

work with sales force data   this module has detail of accessing object from lwc #

###  Apex Rest Callout's

custom apex rest class callouts url end points

/services/apexrest/Accountcontact/0012w00001PVxp1AAD


### lwc communicating with unrelated component using publish subscribe
# different Methods
- samplepage ref
- registered listner 
- unregistered listner 
- unregisteredAll Listner
- fire event

1 import current page reference from lightning/Navigation
2 import publish subscribe from c/pub sub file
  https://github.com/developerforce/pubsub/blob/master/force-app/main/default/lwc/pubsub/pubsub.js

  copy the Pubsub lib code from the above git 
3 implement publish  event 
- 1st param current page reference
- 2nd param event name
- 3rd param variable or reference that has to be passed to subscribe method. 
``` javascript
 publishEvent(){
        fireEvent(this.objectReference,'EventFromPub',this.postalCode);
    }
```
4  create subscrie
- in subscribe implemt connected callback and disconnected callback 

in connected call back
- param 1 event name 
- param 2 method that has to be called in subscribe wor working 
- param 3 current page;
``` javascript
  connectedCallback(){
        registerListener('EventFromPub',this.handlePublish,this);
    }

    disconnectedCallback(){
        unregisterAllListeners(this);
    }
   ``` 
### Custom Metadata Types    
 -   suffix with __mtd
 - def
 Custom metadata is customizable, deployable, packageable, and upgradeable application metadata. First you create a custom metadata type, which defines the form of the application metadata. Then you build reusable functionality that determines the behavior based on metadata of that type. 
- 


### GITHUB
| TO init repo to the locL MACHINE |
| --- |
 |git config --global user.name "First Last" |
| git config --global user.email "you@email.com" |

| use auto carrage return line feed when multiple os handled files used |
| --- |
| git config --global core.autocrlf true |

| create branch git branch branchname |
 | to move pointer to that branch use |
| --- |
| git checkout myfeaturebranch |

| TO add file to staging |
| --- |
| git add filename |

| to commit changes  |
| --- |
| git commit-m "commit message" |

| to publish the branch to remote repo |
| --- |
 |git push -u origin mybranchname     then enter user name and password |

| Shows the recent made chandes logs  |
| --- |
| git log --oneline --graph |

|to check the difference that has been made inthe both files |
| --- |
 | git diff code code |

| undoing changes  |
| --- |
| git revert|

|git reset command that can help rewind the history of our project,|
| --- |
|git reset --soft |
| git reset --mixed |
| git reset --hard |


| git rebase is used to reright history so you can use it care |
| --- |
| git rebase |

| commit --amend to make a modification to the last commit you made. |
| --- |
| commit --amend |



### serializing and Deserializing 


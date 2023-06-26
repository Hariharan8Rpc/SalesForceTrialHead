import { LightningElement,wire,track,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getEmployees from '@salesforce/apex/employeeControllerLwc1.getEmployees';
import getSingleEmployee from '@salesforce/apex/employeeControllerLwc1.getProjectsRelatedToEmployee';
import deleteRecord from '@salesforce/apex/employeeControllerLwc1.getdeleteRecords';
import { NavigationMixin } from 'lightning/navigation';
import Name from '@salesforce/schema/Employee__c.Name';
import Department from '@salesforce/schema/Employee__c.Department__c';
import Address from '@salesforce/schema/Employee__c.Address__c';
import { getListUi } from 'lightning/uiListApi';
import MY_CUSTOM_OBJECT from '@salesforce/schema/Employee__c';

export default class EmployeeList extends NavigationMixin(LightningElement) {
@track employeeList;
@track isShowModal = false;
@track empid;
@track name;
@track singleEmpList;
// 
@api recordId;
@api objectApiName;
name=Name;
department=Department;
address=Address;
city=Address.City__c;
state=Address.State__C;
pincode=Address.Pincode__c;
objectApiName=MY_CUSTOM_OBJECT;

handleNameChange(event){
  this.name = event.target.value;
  console.log(this.name);
} 
  
@wire(getEmployees)
  wiredgetEmployee({error,data}){    
        if(data){
            this.employeeList=data;        
            console.log('employee List form front end '+JSON.stringify(data));
          }
}
// method for getting single employe detail on ID
  getEmployee(){
    console.log('insidde method call '+ this.empid);
    this.recordId=this.empid;
    getSingleEmployee({ EmployeeSearchId:this.empid })
    .then(result => {
      console.log('inside the log call result'+result);
    console.log('single emp list'+JSON.stringify(result));
    this.singleEmpList=result;
    console.log('single emp list1  addr  from  backend ' + JSON.stringify(this.singleEmpList.addr.Name));
    console.log('single emp list1  addr  from  backend ' + this.singleEmpList.addr.Name);
    })
  }

showModalBox(event) { 
// to get the id of the particular row
 this.empid=event.target.name;
 this.getEmployee();
 console.log(' em id from modular button +'+ this.empid);
  this.isShowModal = true;
}

hideModalBox() {  
  this.isShowModal = false;
}

deleteEmployee(event){
    this.empid=event.target.name;
    //    delete method calll
    deleteRecord({ deleteId:this.empid })
    .then(result => {
      if(result=='true'){
    console.log('inside the log call result'+result);
    console.log('single emp list'+JSON.stringify(result));
    this.showSuccessToast(result+'success'+this.empid);
      }else{
        this.showErrorToast('Error'+error);
      }
})
.catch((error) => {
  this.showErrorToast(error);
})
}

showSuccessToast(message) {
  const toastEvent = new ShowToastEvent({
      title: 'Deleted',
      message: message, //'Your email was sent successfully.',
      variant: 'success'
  });
  this.dispatchEvent(toastEvent);
}

showErrorToast(message) {
  const toastEvent = new ShowToastEvent({
      title: 'Error',
      message:message,
      variant: 'error'
  });
  this.dispatchEvent(toastEvent);
} 
// modal code end
}

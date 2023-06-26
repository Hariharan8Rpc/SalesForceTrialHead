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
    //     @wire(getListUi, { objectApiName: OBJECT_API_NAME, listViewApiName: null })
// objectRecords;
// get columns() {
//     if (this.objectRecords.data) {
//         console.log('lods of th data table'+this.objectRecords.data);
//         return FIELD_API_NAMES.map(fieldApiName => ({
           
//             label: this.objectRecords.data.objectInfos[OBJECT_API_NAME].fields[fieldApiName].label,
//             fieldName: fieldApiName,
//             type: this.objectRecords.data.objectInfos[OBJECT_API_NAME].fields[fieldApiName].dataType
//         }));
//     }
//     return [];
// }

// get rows() {
//     if (this.objectRecords.data) {
//         return this.objectRecords.data.records.records.map(record => record.fields);
//     }
//     return [];
// }
@wire(getEmployees)
  wiredgetEmployee({error,data}){    
        if(data){
            this.employeeList=data;        
            console.log('employee List form front end '+JSON.stringify(data));
          
            //  data.forEach(item => {
            //   console.log('lop var'+JSON.stringify(item.addr)); // John, Jane
            //     console.log('  inside loop'+JSON.stringify(item.employee['Name']));
          // });
            // console.log('inner dataaaa-----'+converted.addr);
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

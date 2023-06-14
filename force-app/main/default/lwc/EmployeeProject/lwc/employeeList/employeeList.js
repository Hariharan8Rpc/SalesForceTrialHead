import { LightningElement,wire,track } from 'lwc';
import getEmployees from '@salesforce/apex/employeeControllerLwc1.getEmployees';
import { NavigationMixin } from 'lightning/navigation';
import Name from '@salesforce/schema/Employee__c.Name';
import Department from '@salesforce/schema/Employee__c.Department__c';
import Address from '@salesforce/schema/Employee__c.Address__c';
import { getListUi } from 'lightning/uiListApi';


export default class EmployeeList extends NavigationMixin(LightningElement) {
@track employeeList;

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
            this.employeeList=JSON.stringify(data);
            console.log('employee List form front end '+JSON.stringify(data));
  }
}
}

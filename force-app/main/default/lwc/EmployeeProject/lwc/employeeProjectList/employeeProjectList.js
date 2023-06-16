import { LightningElement,wire ,track} from 'lwc';
import getProjects from '@salesforce/apex/employeeControllerLwc1.GetAllProjects';
export default class EmployeeProjectList extends LightningElement {
    @track employeeProjectList
    @wire(getProjects)
    wiredgetProjects({error,data}){    
          if(data){
              this.employeeProjectList=data;
              console.log('project List form front end '+JSON.stringify(data));              
               data.forEach(item => {
                console.log('lop var'+JSON.stringify(item.addr)); // John, Jane                
            });
              // console.log('inner dataaaa-----'+converted.addr);
            }
  }


}
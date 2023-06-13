import { LightningElement,track } from 'lwc';
	
import { NavigationMixin } from 'lightning/navigation';

export default class EmpProjectHome extends LightningElement {
    @track enableComponent;

    @track showEmployeeListPage=false;
    @track showProjectListPage=false;
    handleValueChange(event) {
      this.enableComponent = event.detail;
      selectOption();   
    }
    selectOption() {
        switch (this.enableComponent) {
          case 'employeeList':
            this.showEmployeeListPage=true;
            this.showProjectListPage=false;
            break;
          case 'projectList':
            this.showEmployeeListPage=false;
            this.showProjectListPage=true;
            break;
          default:
            this.showEmployeeListPage=false;
            this.showProjectListPage=false;
            break;
        }
      }

}
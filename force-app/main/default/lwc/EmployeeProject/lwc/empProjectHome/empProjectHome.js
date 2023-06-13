import { LightningElement,track } from 'lwc';
	
import { NavigationMixin } from 'lightning/navigation';

export default class EmpProjectHome extends LightningElement {
    @track enableComponent;

    @track showEmployeeListPage=false;
    @track showProjectListPage=false;
    message='counter value from child';

    handleValueChange(event) {
      this.message=event.detail.name;
      this.enableComponent = event.detail.name;
      console.log("in parent  "+enableComponent );
      selectOption();   
    }

    selectOption() {
        switch (this.enableComponent) {
          case 'employeeList':
            console.log("in parent  "+this.enableComponent );
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